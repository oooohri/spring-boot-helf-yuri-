<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="kr">

<head>
    <meta charset="utf-8">
    <title>HELF</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="Free HTML Templates" name="keywords">
    <meta content="Free HTML Templates" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&family=Rubik:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="/resources/lib/animate/animate.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/resources/css/style.css" rel="stylesheet">
    <!-- Date Picker  -->
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner"></div>
    </div>
    <!-- Spinner End -->

    <!-- Topnavbar Start -->
   	<jsp:include page="/WEB-INF/views/common/topnavbar.jsp" />
    <!-- Topnavbar End -->

    <!-- Navbar Start -->
    <div class="container-fluid position-relative p-0 h-10 ">
		<jsp:include page="/WEB-INF/views/common/navbar.jsp">
			<jsp:param name="menu" value="이용권"/>
		</jsp:include>
    <!-- Navbar End -->
        <div class="container-fluid bg-primary py-5 bg-header" style="margin-bottom: 10px;">
            <div class="row py-5">
                <div class="col-12 pt-lg-5 mt-lg-5 text-center">
                    <h1 class="display-4 text-white animated zoomIn">MY ORDER</h1>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="searchModal" tabindex="-1">
        <div class="modal-dialog modal-fullscreen">
            <div class="modal-content" style="background: rgba(9, 30, 62, .7);">
                <div class="modal-header border-0">
                    <button type="button" class="btn bg-white btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body d-flex align-items-center justify-content-center">
                    <div class="input-group" style="max-width: 600px;">
                        <input type="text" class="form-control bg-transparent border-primary p-3" placeholder="Type search keyword">
                        <button class="btn btn-primary px-4"><i class="bi bi-search"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </div>
	<div class="container-fluid py-5 wow fadeInUp" data-wow-delay="0.1s">	
		<div class="container py-5 ">
			<div class="section-title text-center position-relative pb-3 mb-5 mx-auto" style="max-width: 600px;">
				<h5 class="fw-bold text-primary text-uppercase">Your Order List</h5>
				<h1 class="mb-0">나의 구매내역</h1>
			</div>
			<div class="row mb-3 d-flex align-items-center justify-content-center">
				<div class="col-10">
					<div class="card" style="margin-bottom: 20px;" >
						<form action="order-list" method="get">
							<input type="hidden" name="page" value="${dto.pagination.page}"/>
							<div class="card-body">							
								<div class="row mb-3 pt-3">
									<label class="col-1 col-form-label text-end" style="margin-left: 50px;">상태</label>
									<div class="col-2">
										<select name="state" class="form-select">
											<option selected="selected" disabled="disabled">전체보기</option>
											<option value="결제완료" ${param.state eq '결제완료' ? 'selected' : '' }>결제완료</option>
											<option value="환불대기" ${param.state eq '환불대기' ? 'selected' : '' }>환불대기</option>
											<option value="환불완료" ${param.state eq '환불완료' ? 'selected' : '' }>환불완료</option>
										</select>
									</div>
									<label class="col-1 col-form-label text-end">종류</label>
									<div class="col-2">
										<select name="type"  class="form-select">
											<option selected="selected" disabled="disabled">전체보기</option>
											<option value="name" ${param.type eq 'name' ? 'selected' : '' }>구매상품</option>
											<option value="no" ${param.type eq 'no' ? 'selected' : '' }>구매번호</option>	
										</select>
									</div>
									<div class="col-3">
										<input type="text" name="keyword" class="form-control" value="${param.keyword }">
									</div>
									<div class="col-2">
										<button type="submit" class="btn btn-success">검색</button>
										<a href="order-list" id="point-return" class="bi bi-arrow-clockwise btn btn-primary"></a>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="card" >
						<div class="card-body">
							<table class="table text-center">
				               	<thead>
									<tr>
				                        <th style="width: 25%;">구매일</th>
				                        <th style="width: 20%">구매번호</th>
				                        <th style="width: 25%">구매상품</th>
				                        <th style="width: 20%">조회</th>
				                    	<th style="width: 20%">비고</th>
									</tr>
								</thead>
								<tbody>
									<c:if test="${empty dto.orders }">
								   		<tr>
									   		<td colspan="5" class="text-center">구매 내역이 없습니다.</td>
								   		</tr>
									</c:if>
								   	<c:forEach var="order" items="${dto.orders }">
										<tr>
					                        <td>${order.paymentDate }</td>
											<td>${order.no }</td>
											<td>${order.name }</td>
											<td>
												<a href="order-detail?no=${order.no }&page=${dto.pagination.page}&state=${param.state }&type=${param.type }&keyword=${param.keyword}" 
												   type="button" class="btn btn-primary btn-sm">상세정보</a>
											</td>
					                        <td>${order.orderState }</td>
			                    		 </tr>
									</c:forEach>
								</tbody>
				        	</table>
	        			</div>
	    			</div>
	    		</div>
	    	</div>
	    </div>
    </div>
	<div class="row mb-3" >
		<div class="col-12">
			<c:if test="${dto.pagination.totalRows gt 0 }">
				<c:set var="currentPage" value="${dto.pagination.page }"></c:set>
				<c:set var="first" value="${dto.pagination.first }"></c:set>
				<c:set var="last" value="${dto.pagination.last }"></c:set>
				<c:set var="prePage" value="${dto.pagination.prePage }"></c:set>
				<c:set var="nextPage" value="${dto.pagination.nextPage }"></c:set>
				<c:set var="beginPage" value="${dto.pagination.beginPage }"></c:set>
				<c:set var="endPage" value="${dto.pagination.endPage }"></c:set>
				<nav>
					<ul class="pagination justify-content-center">
						<li class="page-item ${first ? 'disabled' : '' }">
							<a href="order-list?page=${prePage }" class="page-link" >이전</a>
						</li>
						<c:forEach var="num" begin="${beginPage }" end="${endPage }" >
							<li class="page-item ${num eq currentPage ? 'active' : '' }">
								<a class="page-link" href="order-list?page=${num }" >${num }</a>
							</li>
						</c:forEach>
						<li class="page-item ${last ? 'disabled' : '' }">
							<a href="order-list?page=${nextPage }" class="page-link" >다음</a>
						</li>
					</ul>
				</nav>
			</c:if>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/views/common/footernavbar.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded back-to-top"><i class="bi bi-arrow-up"></i></a>

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/lib/wow/wow.min.js"></script>
    <script src="/resources/lib/easing/easing.min.js"></script>
    <script src="/resources/lib/waypoints/waypoints.min.js"></script>
    <script src="/resources/lib/counterup/counterup.min.js"></script>
    <script src="/resources/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
	<script src="/resources/js/main.js"></script>
</body>
</html>