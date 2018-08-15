#include<iostream>

using namespace std;

template <class T>
class Multiplier {
private:
    T m1, m2;
    T product;
public:
    void printEquation();
    void setM1(T mIn);
    void setM2(T mIn);
    void setProduct();
    T getProduct();
    T getM1();
    T getM2();
};

template <class T>
void Multiplier<T>::printEquation()
{
    std::cout<<m1<<" * "<<m2<<" = "<<product;
}

template <class T>
void Multiplier<T>::setM1(T mIn)
{
   m1 = mIn; 
}

template <class T>
void Multiplier<T>::setM2(T mIn)
{
   m2 = mIn; 
}

template <class T>
void Multiplier<T>::setProduct()
{
   product = m1 * m2; 
}

template <class T>
T Multiplier<T>::getM1()
{
   return m1; 
}

template <class T>
T Multiplier<T>::getM2()
{
   return m2; 
}

template <class T>
T Multiplier<T>::getProduct()
{
   return product; 
}

int main()
{
    Multiplier<int> multi1;
    Multiplier<float> multi3;
    
    cout<<"Enter 2 ints: ";
    int input1,input2;
    cin>>input1;
    cin>>input2;
    
    multi1.setM1(input1);
    multi1.setM2(input2);
    multi1.setProduct();
    multi1.printEquation();
    
    cout<<"\nEnter 2 floats:";
    float input3, input4;
    cin>>input3;
    cin>>input4;    
    multi3.setM1(input3);
    multi3.setM2(input4);
    multi3.setProduct();
    multi3.printEquation();

    cout<<"\n";
    return 0;
}