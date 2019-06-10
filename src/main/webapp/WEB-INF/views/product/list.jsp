<%--
  Created by IntelliJ IDEA.
  User: hrjin
  Date: 2019-06-05
  Time: 오전 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
    <!-- default header name is X-CSRF-TOKEN -->
    <meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
    <title>상품 목록 조회</title>
    <%@include file="../common/commonLibs.jsp" %>
</head>
<body>
<div>
    <div>
        <select onchange="selectBox();" id="categoryList"></select>
    </div>

    <div class="keyword_search">
        <input id="search_keyword" type="text" name="search_keyword" style="-ms-ime-mode: active;" placeholder="상품명 검색" autocomplete="on" onkeypress="if(event.keyCode==13) {gCheckMore = false; search(''); }" value="${listRequest.name}" />

        <button type="button" href="javascript:void(0);" id="btnSearch">검색</button>
    </div>
    <div>
        <tr>
            <td>상품명</td>
            <td>버전</td>
            <td>카테고리</td>
            <td>판매자</td>
            <td>가격</td>
        </tr>
        <div id="productListArea">
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript">

    var CATEGORY_LIST = [];
    var categoryValue;

    var PRODUCT_LIST = [];

    var getCategoryList = function () {
        var reqUrl = "<%=UserConstants.URI_DB_CATEGORY_LIST%>";

        procCallAjax(reqUrl, "GET", null, null, callbackCategoryList);
    };

    var callbackCategoryList = function (data) {
        CATEGORY_LIST = data;

        var categoryListArea = $("#categoryList");
        var htmlArray = [];
        var option = "<option selected='selected' value='ALL'>전체</option>";

        for(var i = 0; i < data.length; i++){
            option += "<option value=" + data[i].id + ">" + data[i].categoryName + "</option>"
        }

        htmlArray.push(option);
        categoryListArea.html(htmlArray);
    };

    var selectBox = function () {
        var selectedCategory = $("#categoryList option:selected").val();
        console.log("선택된 값은? " + selectedCategory);

        sortCategoryProductList(selectedCategory);

    };

    // BIND
    $("#btnSearch").on("click", function() {
        search();
    });

    // SEARCH
    var search = function(){
        var searchKeywordObject = $("#search_keyword");
        var searchKeyword = searchKeywordObject.val();

        searchProductList(searchKeyword);

    };

    var sortCategoryProductList = function (categoryId) {
        var reqUrl = "<%=UserConstants.URI_DB_PRODUCT_LIST%>";

        if (categoryId !== "ALL" && categoryId !== undefined) {
            reqUrl +="?categoryId=" + categoryId;
        }

        procCallAjax(reqUrl, "GET", null, null, callbackGetProductList);
    };

    var searchProductList = function (searchKeyword) {
        var reqUrl = "<%=UserConstants.URI_DB_PRODUCT_LIST%>";

        if ("" !== searchKeyword) {
            reqUrl +="?productName=" + searchKeyword;
        }

        procCallAjax(reqUrl, "GET", null, null, callbackGetProductList);
    };

    // GET LIST
    var getProductList = function() {
        var reqUrl = "<%=UserConstants.URI_DB_PRODUCT_LIST%>";
        procCallAjax(reqUrl, "GET", null, null, callbackGetProductList);
    };


    // CALLBACK
    var callbackGetProductList = function(data) {
        console.log("상품 조회 ::: " + JSON.stringify(data));
        PRODUCT_LIST = data.items;

        var productListArea = $("#productListArea");
        var htmlString = [];
        var listLength = PRODUCT_LIST.length;

        if(listLength > 0){
            for(var i = 0; i < listLength; i++){
                htmlString.push(
                    "<tr>"
                    + "<td>" + PRODUCT_LIST[i].productName + "</td>"
                    + "<td>" + PRODUCT_LIST[i].versionInfo + "</td>"
                    + "<td>" + PRODUCT_LIST[i].category.categoryName + "</td>"
                    + "<td>" + PRODUCT_LIST[i].seller.sellerName + "</td>"
                    + "<td>" + PRODUCT_LIST[i].unitPrice + "원/" + PRODUCT_LIST[i].meteringType + "</td>"
                    +"</tr>"
                );
            }
        }else{
            htmlString = "<tr>"
                + "<td colspan='5'><p class='user_p'>상품이 존재하지 않습니다.</p></td>" + "</tr>"
        }

        productListArea.html(htmlString);
    };


    // ON LOAD
    $(document.body).ready(function () {
        getCategoryList();
        getProductList();
    });
</script>