<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:wrapper>
    <div class="container">
        <header class="blog-header py-3">
            <div class="row flex-nowrap justify-content-between align-items-center">
                <div class="col-4 pt-1">
                    <a class="text-muted" href="/login.jsp">Login</a>
                </div>
                <div class="col-4 text-center">
                    <a class="blog-header-logo text-dark" href="#">Red Rivers</a>
                </div>
                <div class="col-4 d-flex justify-content-end align-items-center">
                    <a class="text-muted" href="#" aria-label="Search">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="none" stroke="currentColor"
                             stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="mx-3" role="img"
                             viewBox="0 0 24 24" focusable="false">
                            <title>Search</title>
                            <circle cx="10.5" cy="10.5" r="7.5" />
                            <path d="M21 21l-5.2-5.2" />
                        </svg>
                    </a>
                    <a class="btn btn-sm btn-outline-secondary" href="register.jsp">Sign up</a>
                </div>
            </div>
        </header>

        <div class="jumbotron p-4 p-md-5 text-white rounded bg-dark">
            <div class="col-md-6 px-0">
                <h1 class="display-4 font-italic">Best bang for your buck </h1>
                <p class="lead my-3">Red River stocks wide selection of semiconductors, electronic components and tools
                    for all your needs.</p>
            </div>
        </div>
        <main role="main" class="container">
            <!-- app (shop) -->
            <div class="row" id="menu" vcloak>

                <div class="col-3">
                    <div class="nav flex-column nav-pills" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                        <a class="nav-link active" id="v-pills-home-tab" data-toggle="pill" href="#v-pills-home"
                           role="tab" aria-controls="v-pills-home" aria-selected="true" @click="activate(1)">Category</a>
                        <a class="nav-link" id="v-pills-profile-tab" data-toggle="pill" href="#v-pills-profile"
                           role="tab" aria-controls="v-pills-profile" aria-selected="false"
                           @click="activate(2)">Category</a>
                        <a class="nav-link" id="v-pills-messages-tab" data-toggle="pill" href="#v-pills-messages"
                           role="tab" aria-controls="v-pills-messages" aria-selected="false"
                           @click="activate(3)">Category</a>
                        <a class="nav-link" id="v-pills-settings-tab" data-toggle="pill" href="#v-pills-settings"
                           role="tab" aria-controls="v-pills-settings" aria-selected="false"
                           @click="activate(4)">Category</a>
                    </div>
                </div>

                <div class="col-9">
                    <div class="tab-content" id="v-pills-tabContent" v-for="item in info[active_el-1].list">
                        <div class="tab-pane fade show active" id="v-pills-home" role="tabpanel"
                             aria-labelledby="v-pills-home-tab">
                            <div class="media">
                                <!--<img src="..." class="mr-3" alt="...">-->
                                <div class="media-body">
                                    <h5 class="mt-0">{{ item.Naziv }}</h5>
                                    Opis: {{ item.Opis }}, Cijena: {{ item.Cijena }} Kn
                                    <div class="form-group row">
                                        <div class="col-10">
                                            <input v-model="item.qty" class="form-control" type="number" min="1" placeholder="Qty">
                                        </div>
                                    </div>
                                    <a type="button" class="btn btn-light btn-sm" @click="addToCart(item)" id="addToCart">Add to cart</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="is-divider" data-content="CART"></div>

                <div class="columns">
                    <div class="column"></div>
                    <div class="column is-three-fifths">
                        <shopping-cart inline-template :items="cartItems">
                            <div>
                                <table class="table is-hoverable">
                                    <tr v-for="(item, ix) in items">
                                        <td>{{item.Naziv}}</td>
                                        <td style="width:120px">QTY:
                                            <input v-model="item.qty" class="form-control input-qty" type="number">
                                        </td>
                                        <td data-tooltip="order note">Note.</td>
                                        <td class="text-right">{{item.Cijena }} Kn</td>
                                        <td>
                                            <button class="oi oi-trash" @click="removeItem(ix)"></button>
                                        </td>
                                    </tr>
                                    <tr v-show="items.length === 0">
                                        <td>Cart is empty</td>
                                    </tr>
                                    <tr v-show="items.length > 0">
                                        <td></td>
                                        <td></td>
                                        <td>Cart Total</td>
                                        <td>{{Total}} Kn</td>
                                        <td><button class="button is-primary is-small modal-button"
                                                    @click="clearCart()">Clear cart</button><button
                                                class="button is-primary is-small modal-button"
                                                @click="isShowModal = true">Order now</button></td>
                                    </tr>
                                </table>

                                <!-- modal -->
                                <div class="modal" v-bind:class="{ 'is-active': isShowModal }">
                                    <div class="modal-background" v-on:click="isShowModal = false"></div>
                                    <div class="modal-card">
                                        <header class="modal-card-head">
                                            <p class="modal-card-title">Checkout</p>
                                            <button class="delete" aria-label="close"
                                                    v-on:click="isShowModal = false"></button>
                                        </header>
                                        <section class="modal-card-body">
                                            <p>We accept: <i class="fab fa-cc-stripe"></i> <i
                                                    class="fab fa-cc-visa"></i> <i class="fab fa-cc-mastercard"></i>
                                                <i class='fab fa-cc-amex'></i> <i class='fab fa-cc-discover'></i></p>
                                            <h3>Total: {{Total}} Kn</h3>
                                            <p> --payment processor-- </p>
                                        </section>
                                        <footer class="modal-card-foot">
                                            <button class="button" v-on:click="isShowModal = false">Cancel</button>
                                            <button class="button" title="Disabled button" disabled>Buy</button>
                                        </footer>
                                    </div>
                                </div>
                            </div>
                        </shopping-cart>
                    </div>
                </div>

            </div>

            <br><br>






            <!-- newsletter -->
            <div class="row">
                <div class="col-md-8 blog-main">
                    <h3 class="pb-4 mb-4 font-italic border-bottom">
                        Our newsletter
                    </h3>

                    <div class="blog-post">
                        <h2 class="blog-post-title">Sample letter</h2>
                        <p class="blog-post-meta">January 1, 2014 by <a href="#">Tom</a></p>

                        <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur
                            ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis
                            vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet
                            fermentum.</p>
                        <blockquote>
                            <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong>
                                ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                        </blockquote>
                        <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit
                            amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
                        <h2>Heading</h2>
                        <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non
                            commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus,
                            porta ac consectetur ac, vestibulum at eros.</p>
                        <h3>Sub-heading</h3>
                        <p>Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.</p>
                        <pre><code>Example code block</code></pre>
                        <p>Aenean lacinia bibendum nulla sed consectetur. Etiam porta sem malesuada magna mollis
                            euismod. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut
                            fermentum massa.</p>
                    </div><!-- /.blog-post -->

                    <div class="blog-post">
                        <h2 class="blog-post-title">Another letter</h2>
                        <p class="blog-post-meta">December 23, 2013 by <a href="#">Tom</a></p>

                        <p>Cum sociis natoque penatibus et magnis <a href="#">dis parturient montes</a>, nascetur
                            ridiculus mus. Aenean eu leo quam. Pellentesque ornare sem lacinia quam venenatis
                            vestibulum. Sed posuere consectetur est at lobortis. Cras mattis consectetur purus sit amet
                            fermentum.</p>
                        <blockquote>
                            <p>Curabitur blandit tempus porttitor. <strong>Nullam quis risus eget urna mollis</strong>
                                ornare vel eu leo. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                        </blockquote>
                        <p>Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur purus sit
                            amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
                        <p>Vivamus sagittis lacus vel augue laoreet rutrum faucibus dolor auctor. Duis mollis, est non
                            commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Morbi leo risus,
                            porta ac consectetur ac, vestibulum at eros.</p>
                    </div><!-- /.blog-post -->

                    <nav class="blog-pagination">
                        <a class="btn btn-outline-primary" href="#">Older</a>
                        <a class="btn btn-outline-secondary disabled" href="#" tabindex="-1"
                           aria-disabled="true">Newer</a>
                    </nav>

                </div><!-- /.blog-main -->

                <aside class="col-md-4 blog-sidebar">
                    <div class="p-4 mb-3 bg-light rounded">
                        <h4 class="font-italic">About</h4>
                        <p class="mb-0">Etiam porta <em>sem malesuada magna</em> mollis euismod. Cras mattis consectetur
                            purus sit amet fermentum. Aenean lacinia bibendum nulla sed consectetur.</p>
                    </div>

                    <div class="p-4">
                        <h4 class="font-italic">Archives</h4>
                        <ol class="list-unstyled mb-0">
                            <li><a href="#">March 2014</a></li>
                            <li><a href="#">February 2014</a></li>
                            <li><a href="#">January 2014</a></li>
                            <li><a href="#">December 2013</a></li>
                            <li><a href="#">November 2013</a></li>
                            <li><a href="#">October 2013</a></li>
                        </ol>
                    </div>

                    <div class="p-4">
                        <h4 class="font-italic">Elsewhere</h4>
                        <ol class="list-unstyled">
                            <li><a href="#">GitHub</a></li>
                            <li><a href="#">Twitter</a></li>
                            <li><a href="#">Facebook</a></li>
                        </ol>
                    </div>
                </aside><!-- /.blog-sidebar -->

            </div><!-- /.row -->

        </main><!-- /.container -->
    </div>
</t:wrapper>