<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Base64"%>
<%@page import="domain.Image"%>
<%@page import="control.MaintainImageControl"%>
<%@page import="control.MaintainOrderControl"%>
<%@page import="domain.Order"%>
<%@page import="domain.Product"%>
<%@page import="control.MaintainProductControl"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<jsp:include page="../startupServlet" flush="true" />--%>
<!DOCTYPE html>
<html>
    <head>
        <title>${companyName} | Milo Goh Pet Supplies</title>
        <%@ include file="header.jsp" %>
    </head>
    <body>                                
        <%
            MaintainOrderControl orderControl = new MaintainOrderControl();
            ArrayList<Order> orderRecords = orderControl.getOrdersByStatus("Paid");
            ArrayList<Integer> checkedProductIds = new ArrayList<Integer>();
            ArrayList<Product> productList = new ArrayList<Product>();
            ArrayList<Integer> qtyList = new ArrayList<Integer>();
            int rank = 1;
            for (Order order : orderRecords) {

                int productId = order.getProductId();
                MaintainProductControl prodControl = new MaintainProductControl();
                Product product = prodControl.selectProductById(order.getProductId());
                if (!checkedProductIds.contains(productId)) {
                    int totalQuantity = 0; //initialize total quantity

                    for (Order o : orderRecords) {
                        if (o.getProductId() == productId) {
                            totalQuantity += o.getProductQty();
                        }
                    }
                    rank++;
                    qtyList.add(totalQuantity);
                    checkedProductIds.add(productId);
                    productList.add(product);
                }

                //stop at 6
                if (rank == 6) {
                    break;
                }
            }
            //reareange
            for (int i = 0; i < checkedProductIds.size() - 1; i++) {
                for (int j = i + 1; j < checkedProductIds.size(); j++) {
                    int qty1 = qtyList.get(i);
                    int qty2 = qtyList.get(j);
                    if (qty1 < qty2) {
                        Product temp = productList.get(i);
                        productList.set(i, productList.get(j));
                        productList.set(j, temp);

                        int temp2 = qtyList.get(i);
                        qtyList.set(i, qtyList.get(j));
                        qtyList.set(j, temp2);
                    }
                }
            }
        %>
        <header class="bg-primary py-5">
            <div class="container px-4 px-lg-5 my-5">
                <div class="text-center text-white">
                    <% if (account.getAccountID() > 0 && account.getBirthday().equals(date)) {%>
                    <h1 class="display-4 fw-bolder"><svg xmlns="http://www.w3.org/2000/svg" width="42" height="42" fill="currentColor" class="bi bi-cake2" viewBox="0 0 16 16">
                        <path d="m3.494.013-.595.79A.747.747 0 0 0 3 1.814v2.683q-.224.051-.432.107c-.702.187-1.305.418-1.745.696C.408 5.56 0 5.954 0 6.5v7c0 .546.408.94.823 1.201.44.278 1.043.51 1.745.696C3.978 15.773 5.898 16 8 16s4.022-.227 5.432-.603c.701-.187 1.305-.418 1.745-.696.415-.261.823-.655.823-1.201v-7c0-.546-.408-.94-.823-1.201-.44-.278-1.043-.51-1.745-.696A12 12 0 0 0 13 4.496v-2.69a.747.747 0 0 0 .092-1.004l-.598-.79-.595.792A.747.747 0 0 0 12 1.813V4.3a22 22 0 0 0-2-.23V1.806a.747.747 0 0 0 .092-1.004l-.598-.79-.595.792A.747.747 0 0 0 9 1.813v2.204a29 29 0 0 0-2 0V1.806A.747.747 0 0 0 7.092.802l-.598-.79-.595.792A.747.747 0 0 0 6 1.813V4.07c-.71.05-1.383.129-2 .23V1.806A.747.747 0 0 0 4.092.802zm-.668 5.556L3 5.524v.967q.468.111 1 .201V5.315a21 21 0 0 1 2-.242v1.855q.488.036 1 .054V5.018a28 28 0 0 1 2 0v1.964q.512-.018 1-.054V5.073c.72.054 1.393.137 2 .242v1.377q.532-.09 1-.201v-.967l.175.045c.655.175 1.15.374 1.469.575.344.217.356.35.356.356s-.012.139-.356.356c-.319.2-.814.4-1.47.575C11.87 7.78 10.041 8 8 8c-2.04 0-3.87-.221-5.174-.569-.656-.175-1.151-.374-1.47-.575C1.012 6.639 1 6.506 1 6.5s.012-.139.356-.356c.319-.2.814-.4 1.47-.575M15 7.806v1.027l-.68.907a.94.94 0 0 1-1.17.276 1.94 1.94 0 0 0-2.236.363l-.348.348a1 1 0 0 1-1.307.092l-.06-.044a2 2 0 0 0-2.399 0l-.06.044a1 1 0 0 1-1.306-.092l-.35-.35a1.935 1.935 0 0 0-2.233-.362.935.935 0 0 1-1.168-.277L1 8.82V7.806c.42.232.956.428 1.568.591C3.978 8.773 5.898 9 8 9s4.022-.227 5.432-.603c.612-.163 1.149-.36 1.568-.591m0 2.679V13.5c0 .006-.012.139-.356.355-.319.202-.814.401-1.47.576C11.87 14.78 10.041 15 8 15c-2.04 0-3.87-.221-5.174-.569-.656-.175-1.151-.374-1.47-.575-.344-.217-.356-.35-.356-.356v-3.02a1.935 1.935 0 0 0 2.298.43.935.935 0 0 1 1.08.175l.348.349a2 2 0 0 0 2.615.185l.059-.044a1 1 0 0 1 1.2 0l.06.044a2 2 0 0 0 2.613-.185l.348-.348a.94.94 0 0 1 1.082-.175c.781.39 1.718.208 2.297-.426"/>
                        </svg>   Enjoy Promotion Of <%=promotion.getDiscount()%>% Today !

                    </h1>
                    <p class="lead fw-normal text-white-50 mb-0"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-balloon-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8.48 10.901C11.211 10.227 13 7.837 13 5A5 5 0 0 0 3 5c0 2.837 1.789 5.227 4.52 5.901l-.244.487a.25.25 0 1 0 .448.224l.04-.08c.009.17.024.315.051.45.068.344.208.622.448 1.102l.013.028c.212.422.182.85.05 1.246-.135.402-.366.751-.534 1.003a.25.25 0 0 0 .416.278l.004-.007c.166-.248.431-.646.588-1.115.16-.479.212-1.051-.076-1.629-.258-.515-.365-.732-.419-1.004a2 2 0 0 1-.037-.289l.008.017a.25.25 0 1 0 .448-.224zM4.352 3.356a4 4 0 0 1 3.15-2.325C7.774.997 8 1.224 8 1.5s-.226.496-.498.542c-.95.162-1.749.78-2.173 1.617a.6.6 0 0 1-.52.341c-.346 0-.599-.329-.457-.644"/>
                        </svg>  <%=promotion.getDescription()%>  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-balloon" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8 9.984C10.403 9.506 12 7.48 12 5a4 4 0 0 0-8 0c0 2.48 1.597 4.506 4 4.984M13 5c0 2.837-1.789 5.227-4.52 5.901l.244.487a.25.25 0 1 1-.448.224l-.008-.017c.008.11.02.202.037.29.054.27.161.488.419 1.003.288.578.235 1.15.076 1.629-.157.469-.422.867-.588 1.115l-.004.007a.25.25 0 1 1-.416-.278c.168-.252.4-.6.533-1.003.133-.396.163-.824-.049-1.246l-.013-.028c-.24-.48-.38-.758-.448-1.102a3 3 0 0 1-.052-.45l-.04.08a.25.25 0 1 1-.447-.224l.244-.487C4.789 10.227 3 7.837 3 5a5 5 0 0 1 10 0m-6.938-.495a2 2 0 0 1 1.443-1.443C7.773 2.994 8 2.776 8 2.5s-.226-.504-.498-.459a3 3 0 0 0-2.46 2.461c-.046.272.182.498.458.498s.494-.227.562-.495"/>
                        </svg></p>
                        <% } else if (promotion.getPromotionid() > 0) {%>
                    <h1 class="display-4 fw-bolder">Enjoy Promotion Of <%=promotion.getDiscount()%>% Today !</h1>
                    <p class="lead fw-normal text-white-50 mb-0"><%=promotion.getDescription()%></p>
                    <% } else { %>
                    <h1 class="display-4 fw-bolder">Welcome to ${companyName}</h1>
                    <p class="lead fw-normal text-white-50 mb-0">With ALL you NEED and ALL you can AFFORD !</p>
                    <% } %>
                </div>
            </div>
        </header>
        <section class="mb-5">
            <div class="container px-4 px-lg-5 mt-5">
                <div class="text-center">
                    <h1 class="display-4 fw-bolder">Featured Product</h1>
                </div>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <% for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);

                            int imageId = product.getImage().getId();
                            MaintainImageControl imageControl = new MaintainImageControl();
                            Image image = imageControl.selectImageById(imageId);

                            byte[] imageData = image.getImage1();
                            String base64Image = Base64.getEncoder().encodeToString(imageData);
                    %>
                    <div class="col-4 mb-5">
                        <div class="card h-100">
                            <!-- Product image-->
                            <img class="card-img-top" src="data:image/jpeg;base64, <%= base64Image%>" />
                            <!-- Product details-->
                            <div class="card-body p-4">
                                <div class="text-center">
                                    <!-- Product name-->
                                    <h5 class="fw-bolder"><%=product.getName()%></h5>
                                    <!-- Product price-->
                                    Original Price : RM<%=product.getUnitPrice()%>
                                </div>
                            </div>
                            <!-- Product actions-->
                            <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="ProductDetailPage.jsp?id=<%=product.getId()%>">View Details</a></div>
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
        </section>
        <%@ include file="footer.jsp" %>
    </body>
</html>