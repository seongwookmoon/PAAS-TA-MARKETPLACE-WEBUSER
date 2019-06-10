package org.openpaas.paasta.marketplace.web.user.product;

import org.openpaas.paasta.marketplace.web.user.common.CommonService;
import org.openpaas.paasta.marketplace.web.user.common.UserConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 상품 Controller
 *
 * @author hrjin
 * @version 1.0
 * @since 2019-06-04
 */
@RestController
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CommonService commonService;


    /**
     * 상품 목록 조회 페이지 이동
     *
     * @param httpServletRequest the http servlet request
     * @return ModelAndView
     */
    @GetMapping(value = UserConstants.URI_WEB_USER_PRODUCT_LIST)
    public ModelAndView getProductListPage(HttpServletRequest httpServletRequest,
                                           @RequestParam(value = "categoryId", required = false) Long categoryId,
                                           @RequestParam(value = "productName", required = false) String productName){
        return commonService.setPathVariables(httpServletRequest, UserConstants.URI_VIEW_PRODUCT + "/list", new ModelAndView());
    }


    /**
     * 상품 목록 조회
     *
     * @return ProductList
     */
    @GetMapping(value = UserConstants.URI_DB_PRODUCT_LIST)
    public ProductList getProductList(HttpServletRequest httpServletRequest){
        return productService.getProductList(commonService.setParameters(httpServletRequest));
    }
}