<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="leftCnt on">
	<div class="gnbMenu">
		<div class="gnb-in" id="leftMenu">
			<!-- depth1 START -->
			<ul class="gnb-menu dept1 depth1">
				<li class="dept1">
					<a class="dept1 on" href="javascript:void(0);" onclick="depth1Click(event);"><span class="ico ico-bul ico1"></span>상품 목록</a>
				</li>
				<li class="dept1">
					<a class="dept1" href="javascript:void(0);" onclick="depth1Click(event);"><span class="ico ico-bul ico2"></span>마이 페이지<span class="ico ico-arr"></span></a>
					<ul class="dept2" style="display:none;">
						<li class="dept2">
							<a class="dept2" href="/market/user/product">사용 상품</a>
						</li>
						<li class="dept2">
							<a class="dept2" href="">요금 계산</a>
						</li>
					</ul>
					<!-- dept2 END -->
				</li>
			</ul>
			<!-- depth1 END -->
		</div>
	</div>
</div>