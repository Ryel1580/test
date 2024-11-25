<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>

<%@include file="/WEB-INF/jsp/biz/include/head.jsp"%>

<body class="hold-transition skin-blue sidebar-mini">

<div class="wrapper">

	<!-- Main Header -->
    <%@ include file="/WEB-INF/jsp/biz/include/main_header.jsp"%>

    <!-- Left side column. contains the logo and sidebar -->
    <%@ include file="/WEB-INF/jsp/biz/include/left_column.jsp"%>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header" style="margin-left:30px; margin-right:30px;">
            <h1><spring:message code="lkSysMn.title"/></h1>
        </section>

        <!-- Main content -->
        <section class="content container-fluid" style="margin-right:30px;">

			<div>
				<!-- 검색 영역 -->
	            <div class="box box-info">
	            	<nav class="navbar navbar-default" role="navigation">
						<form id="mainActionForm" name="mainActionForm" method="post">
							<div class="navbar-form">
								
								<!-- hidden value -->
								<input type="hidden" class="form-control" id="rcvZnId" name="rcvZnId" value="${ssZnId }">
								<input type="hidden" class="form-control" id="sndZnId" name="sndZnId">
								<input type="hidden" class="form-control" id="sysCd" name="sysCd">
								
								<div class="input-group">
								    <input type="text" class="form-control" placeholder='<spring:message code="lkSysMn.sndZnNm"/>' id="sndZnNm"  name="sndZnNm">
								</div>
								<div class="input-group">
								    <input type="text" class="form-control" placeholder='<spring:message code="lkSysMn.lkSysNm"/>' id="lkSysNm"  name="lkSysNm">
								</div>
								<div class="input-group">
								    <button class="btn btn-search" type="button" id="btnSearch"><i class="fa fa-search fa-fw"></i> <spring:message code="button.search"/></button>
								</div>
								<div class="input-group">
								    <button class="btn btn-primary" type="button" id="btnLkSysMnReg" onclick="javascript:oLkSysMnList.reg();"><spring:message code="button.create"/></button>
								</div>
								
							</div>
						</form>
					</nav>
	            </div>
	            <!-- // 검색 영역 -->

				<!-- 그리드 영역 -->
				<div class="box">
					<div class="box-body">
						<table id="grid" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th><spring:message code="lkSysMn.lkArea"/></th>
									<th><spring:message code="lkSysMn.rcvZnNm"/></th>
									<th><spring:message code="lkSysMn.sndZnNm"/></th>
									<th><spring:message code="lkSysMn.lkSysNm"/></th>
									<th><spring:message code="lkSysMn.lkSysDc"/></th>
									<th><spring:message code="lkSysMn.lkDtls"/></th>
								</tr>
							</thead>

							<tbody>
								<tr>
									<td>LK_AREA</td>
									<td>RCV_ZN_NM</td>
									<td>SND_ZN_NM</td>
									<td>LK_SYS_NM</td>
									<td>LK_SYS_DC</td>
									<td>LK_DTLS</td>
									<td>RCV_ZN_ID</td>
									<td>SND_ZN_ID</td>
									<td>SYS_CD</td>
								</tr>
						</table>
					</div>
				</div>
				<!-- //그리드 영역 -->

				<!-- 메인 등록 영역 -->
				<div id="mainRegDiv"></div>
				<!-- // 메인 등록 영역 -->
			</div>


        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
</div>

<!-- Main Footer -->
<%@ include file="/WEB-INF/jsp/biz/include/plugin_js.jsp"%>

<script type="text/javascript">

	$(document).ready(function(){

		oLkSysMnList = new lkSysMnList();
		oLkSysMnList.init();
		
		// 검색
		$("#btnSearch").bind("click", function(){
			/* 마우스 Click시 특수문자 제거 */
			oLkSysMnList.search();
		});

		$('#sndZnNm').keyup(function(e) {
			
		    if (e.keyCode == 13){
		    	/* Enter 입력시 특수문자 제거 */
		    	oLkSysMnList.search();
		    }
		});

		$('#lkSysNm').keyup(function(e) {
		    if (e.keyCode == 13){
		    	/* Enter 입력시 특수문자 제거 */
		    	oLkSysMnList.search();
		    }
		});
		$('#grid tbody').on('dblclick', 'tr', function (a,b,c) {
			
			var data = $("#grid").dataTable().fnGetData(this);
			document.mainActionForm.rcvZnId.value = data.RCV_ZN_ID;
			document.mainActionForm.sndZnId.value = data.SND_ZN_ID;
			document.mainActionForm.sysCd.value = data.SYS_CD;
			document.mainActionForm.action = "<c:url value='/biz/system/lkSys/lkSysMn/detail.do'/>";
			document.mainActionForm.submit();
		});

	});

function lkSysMnList(){

	this.init = function(){
		oLkSysMnList.grid();
	};

	this.grid = function() {
		
		$('#grid').dataTable({
              pageLength: oComGridInfo.defaultPageLength
            , bPaginate: true
            , bLengthChange: true
            , lengthMenu : [ oComGridInfo.dataRow1, oComGridInfo.dataRow2 ]
			, bAutoWidth: false
			, processing: true
			, ordering: true
			, searching: false
			, ajax : {
            	  type : "POST"
            	, url: "/biz/system/lkSys/lkSysMn/mainList.json"
            	, data : function(d){
                	var formData = {};
            		$.each($('#mainActionForm').serializeArray(), function() {
            			formData[this.name] = this.value;
            		});
                	return formData;
            	}
				, dataSrc:"data"
				
            }
			, columns : [
				  {data: "LK_AREA"}
			    , {data: "RCV_ZN_NM"}
				, {data: "SND_ZN_NM"}
				, {data: "LK_SYS_NM"}
				, {data: "LK_SYS_DC"}
				, {data: "LK_DTLS"}
				, {data: "RCV_ZN_ID"}
				, {data: "SND_ZN_ID"}
				, {data: "SYS_CD"}
            ]
			, columnDefs: [
				{ 
					  targets : [6,7,8]
					, visible : false					
	        	}
				, {
					  targets : 0
					, render : function (data){
						var result = '<spring:message code="lkSysMn.Is"/>';
						if (data == 'ES') result = '<spring:message code="lkSysMn.Es"/>';
						return result;
					}
				}
			] 

        });

	};

	this.gridReload = function(){
		$("#grid").DataTable().ajax.reload();
		$("#mainRegDiv").empty().removeClass("box box-info");
	};

	this.reg = function(){
		
		var url = "<c:url value='/biz/system/lkSys/lkSysMn/Insert.do'/>";
		var rcvZnId = $('#rcvZnId').val();
		$.ajax({
			  type : "POST"
			, url : url
			, data : {
				rcvZnId : rcvZnId
			}
			, success : function(data) {
				$("#mainRegDiv").empty().removeClass("box box-info");
				$('#mainRegDiv').append(data).addClass("box box-info");
			}
			, error : function(xhr, status, error) {
				alert("<spring:message code='fail.request.msg'/>");
			}
		});

	};
	
	this.search = function(){
		
		/* 특수문자 정규식 */
		var regex = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\" ]/g;
		
		var temp=$('#sndZnNm').val();
    	$('#sndZnNm').val(temp.replace(regex,''));
    	
    	var temp2=$('#lkSysNm').val();
    	$('#lkSysNm').val(temp2.replace(regex,''));
		oLkSysMnList.gridReload();
	}

}

</script>

</body>
</html>
