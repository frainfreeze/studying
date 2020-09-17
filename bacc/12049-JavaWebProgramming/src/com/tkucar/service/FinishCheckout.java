package com.tkucar.service;

import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;
import com.tkucar.Models.Product;
import com.tkucar.util.DBConnection;
import com.tkucar.util.DBHelper;
import com.tkucar.util.DBLogger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONObject;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class FinishCheckout extends HttpServlet {
    DBConnection dBConnection;
    Connection con;
    private APIContext apiContext = new APIContext("ATzQ02ZFxIPPzRHDCXGD-QJMJhT66pDutIKFTyxAwzI1Q0jdPR5L0bPv1njQE3gM8Ep1FYClwEwKgFlh", "EIHTuXjh9Jd70K_jTFbA495em5OFyIxs-2t-kp_CvFwb86FMa-Ba7kuYS3af72OizT1cbieA4Tm_l4Cg","sandbox");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getSession().getAttribute("authenticated") != null) {
            String jsonString = request.getParameter("items");
            JSONArray jsonArr = new JSONArray(jsonString);
            List<Product> productList = new ArrayList<Product>();
            for (int i = 0; i < jsonArr.length(); i++) {
                JSONObject jsonObj = jsonArr.getJSONObject(i);
                Product product = new Product();
                product.setId(jsonObj.getInt("ItemId"));
                product.setItem(jsonObj.getString("Item"));
                product.setDesc(jsonObj.getString("Desc"));
                product.setPrice(jsonObj.getInt("Price"));
                product.setQty(jsonObj.getInt("qty"));
                productList.add(product);
            }


            List<Item> items = new ArrayList<Item>();
            double total = 0;

            for(Product p: productList){
                items.add((new Item()).setName(p.getItem()).setQuantity(Integer.toString(p.getQty())).setCurrency(("USD")).setPrice(String.valueOf(p.getPrice())));
                total+=p.getPrice();
            }

            ItemList itemList = new ItemList();
            itemList.setItems(items);
            Details details = new Details();
            details.setShipping("1");
            details.setSubtotal(String.valueOf(total));
            details.setTax("1");
            Amount amount = new Amount();
            amount.setCurrency("USD");
            amount.setTotal(String.valueOf(total+2));
            amount.setDetails(details);
            Transaction transaction = new Transaction();
            transaction.setAmount(amount);
            transaction.setDescription("Thank you for shopping in Red Rivers web shop");
            transaction.setItemList(itemList);
            List<Transaction> transactions = new ArrayList<Transaction>();
            transactions.add(transaction);

            Payer payer = new Payer();
            payer.setPaymentMethod("paypal");

            Payment payment = new Payment();
            payment.setIntent("sale");
            payment.setPayer(payer);
            payment.setTransactions(transactions);

            RedirectUrls redirectUrls = new RedirectUrls();
            String guid = UUID.randomUUID().toString().replaceAll("-", "");
            String scheme = request.getScheme();
            String serverName = request.getServerName();
            int serverPort = request.getServerPort();
            redirectUrls.setCancelUrl(scheme + "://" + serverName+ ":" + serverPort + "/paypal_fail?guid=" + guid);
            redirectUrls.setReturnUrl(scheme + "://" + serverName+ ":" + serverPort + "/paypal_success?guid=" + guid);
            payment.setRedirectUrls(redirectUrls);

            try {
                Payment createdPayment = payment.create(apiContext);
                for (Links link : createdPayment.getLinks()) {
                    if (link.getRel().equalsIgnoreCase("approval_url")) {
                        response.sendRedirect(link.getHref());
                    }
                }
                dBConnection = new DBConnection();
                PreparedStatement ps = con.prepareStatement(
                        "insert into purchase (user_id, purchase_type) values(?,?)");
                ps.setString(1, "1");
                ps.setString(2, request.getParameter("purchaseType"));
                int i = ps.executeUpdate();
            } catch (PayPalRESTException | SQLException e) {
                System.err.println(e.getDetails());
            }
        } else {
            RequestDispatcher view = request.getRequestDispatcher("login.jsp");
            view.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher view = request.getRequestDispatcher("app/checkout.jsp");
        view.forward(request, response);
    }
}
