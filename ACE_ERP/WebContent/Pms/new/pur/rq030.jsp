<!-- /******************************************************************************
 * 시스템명 	 : 구매의뢰서 - 견적
 * 프로그램ID 	 : PMS/RQ030
 * J  S  P	 	 : rq030.jsp
 * 서 블 릿		 : 
 * 작 성 자		 : 김도연
 * 작 성 일		 : 2018-05-30
 * 기능정의		 : 구매의뢰서 - 견적
 * [ 수정일자 ][수정자] 내용
 * [ 2018-06-20 ][김도연] 신규개발

 *****************************************************************************/ -->


<%@ page language="java" contentType="text/html;charset=euc-kr" %>

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>


<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	SmartRequest sr = new SmartRequest(request);	

	//로그인 체크 : 2013-12-04 심동현 수정 ///////////////////////////////////////////////////////////////////////////////////////
	String gusrid	= (String)session.getAttribute("vusrid");
	String gusrnm	= (String)session.getAttribute("vusrnm");
	String ssID		= sr.getString("ssID");				//페이지 이동시 세션ID 체크(이건 웬만한 곳은 하지 말끄나?)
	String gusrpos	= (String)session.getAttribute("vusrpos");	//페이지 이동시 세션변수("로긴") 체크
	String gusrip	= (String)session.getAttribute("vusrip");	//페이지 이동시 IP변경 체크
%>



<!DOCTYPE html>
<html lang="ko-KR">

	<head>
	<!-- <meta charset=euc-kr"> -->
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<meta http-equiv="Cache-control" content="no-cache"/>
	<meta http-equiv="Cache-control" content="no-store"/>
	<meta http-equiv="pragma" content="no-cache" />
	<meta name="viewport" content="width=1080" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />

	<jsp:include page="/Pms/common/include/head.jsp"/>
	

<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">



	var v_default_row = 1; 				//디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; 					//Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;						//새창 띄우기용.
	
	var fnSelect3_cnt;					//기존 행 개수
	
	
		
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
		
		cfStyleGrid(getObjectFirst("gr_default"), "comn");	//card usage list
		
		cfStyleGrid(getObjectFirst("gr_default2"), "comn");	//card usage list
		
		cfStyleGrid(getObjectFirst("gr_default3"), "comn");	//card usage list


		
	}

	
    <%//초기작업 %>
    function fnInit() {

	    v_job ="I";

    }
    
	
	
    <%//메인 조회 %>
    function fnSelect() {
    	
    	
    	if(v_request_no.value==""){
    		
    		
    		alert("구매의뢰서를 검색해주세요.");
    		
    		
    	}else{
    		
    		
	    	fnSelect1();
	    	
	    	fnSelect2();
	    	
	    	fnSelect3();
	    	
    	}
    	
    	
    }
    
    
    
    <%//기본 정보 list %>
    function fnSelect1() {
    	
    	
    	v_job="S";
    	
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_project_code=" + v_project_code.value	//project code , 검색조건
										+ ",v_request_no="   + v_request_no.value	//구매의뢰서 번호, 검색조건
										;


        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT=ds_default)", 
		            param);

        
        tr_post(tr1);
        
        
    }
    
    
    
    
    <%//청구 품목 list %>
    function fnSelect2() {
    	
    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
										+ ",v_project_code=" + v_project_code.value	//project code , 검색조건
										+ ",v_request_no="   + v_request_no.value	//구매의뢰서 번호, 검색조건
										;
        
        //alert("praram == "+param);
        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT2=ds_default2)", 
		            param);
        
        //prompt(this, param);
        //prompt(this, ds_culds);"JSP(O:DS_CULDS=ds_culds)", //화면 출력. o ->output
        
        tr_post(tr1);
        
        
    }    
    
    
    
    
    <%//견적 업체 list %>
    function fnSelect3() {
    	

    	v_job="S";
    	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>" 
									+ ",v_project_code=" + v_project_code.value	//project명 , 검색조건
									+ ",v_request_no="   + v_request_no.value	//구매의뢰서 번호, 검색조건
									;
        
        //alert("praram == "+param);
        

        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		            "JSP(O:DS_DEFAULT3=ds_default3)", //화면 출력. o ->output
		            param);
        
        //prompt(this, param);
        //prompt(this, ds_cul);
        
        tr_post(tr1);
        
        //alert("행 개수 : "+ds_default3.countrow);
        
        fnSelect3_cnt = ds_default3.countrow;
        
        
    }
    
    
    
    
    

    
    
    
    

    <%//저장 %>
	function fnApply(){
		
		
			v_job = "A";
			
			
			v_default_row = ds_default.RowPosition;
			
			
			
			//alert("1");
			//alert(v_default_row+"========v_default_row");
			
			<%-- if (ds_cul.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_CUL=ds_cul,I:DS_CUL=ds_cul)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
	        		tr_post(tr1);
	        	}
			}else {
	     		alert("업데이트된 행이 없습니다.");
		 	} --%>
		 	<%-- if (ds_cul.IsUpdated) {
				if(ln_Chk()){
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq010",
	                "JSP(I:DS_CUL=ds_cul,I:DS_CUL=ds_cul)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
	        		tr_post(tr1);
	        		alert("2");
	        	}
			}else {
	     		alert("업데이트된 행이 없습니다.");
		 	} --%>
		 	//var v_project_code.value
		 	
		 	
		 	
		 	
		 	var v_no_estimate		=	ds_default3.namevalue(ds_default3.rowposition,"NO_ESTIMATE"); 			//견적서 번호
		 	var v_cost_cd			=	ds_default3.namevalue(ds_default3.rowposition,"COST_CD"); 					//project code
		 	var v_no_ma_request		=	ds_default3.namevalue(ds_default3.rowposition,"NO_MA_REQUEST"); 				//구매의뢰서 번호
		 	var v_vend_nm			=	ds_default3.namevalue(ds_default3.rowposition,"VEND_NM"); 				//업체명
		 	var v_cd_vendor			=	ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR"); 			//사업자 등록번호
		 	var v_vd_direct			=	ds_default3.namevalue(ds_default3.rowposition,"VD_DIRECT"); 			//대표자
		 	var v_bsns_cnd			=	ds_default3.namevalue(ds_default3.rowposition,"BSNS_CND"); 				//업태
		 	var v_bsns_knd			=	ds_default3.namevalue(ds_default3.rowposition,"BSNS_KND"); 				//업종
		 	var v_vd_telno			=	ds_default3.namevalue(ds_default3.rowposition,"VD_TELNO"); 				//연락처
		 	var v_am_estimate		=	ds_default3.namevalue(ds_default3.rowposition,"AM_ESTIMATE"); 			//견적 금액
		 	var v_choice_reason		=	ds_default3.namevalue(ds_default3.rowposition,"CHOICE_REASON"); 		//선정 사유
		 	var v_yn_select			=	ds_default3.namevalue(ds_default3.rowposition,"YN_SELECT"); 			//선정 여부
		 	
		 	
		 	//유효성 검사 check
		 	//alert("기존 행 개수 : "+fnSelect3_cnt);
		 	//alert("추가된 행 개수 : "+ds_default3.countrow);
		 	
		 	
		 	if(fnSelect3_cnt<ds_default3.countrow){
		 		
		 		for ( i=1;i<=fnSelect3_cnt;i++){
		 			
		 			for(j=(fnSelect3_cnt+1);j<=ds_default3.countrow;j++){
		 				
		 			 
		 			//alert("들어옴");
			 		//alert("기존 데이터 : "+ds_default3.namevalue(i,"CD_VENDOR"));
			 		//alert("새로운 데이터 : "+ds_default3.namevalue(j,"CD_VENDOR"));
			 		//alert("기존 데이터 : "+ds_default3.namevalue(i,"YN_SELECT"));
			 		//alert("새로운 데이터 : "+ds_default3.namevalue(j,"YN_SELECT"));
			 		
			 		
			 	
						if (ds_default3.namevalue(i,"CD_VENDOR") ==ds_default3.namevalue(j,"CD_VENDOR")){
							
							alert(i+"번째행에 사업자등록번호가 중복되었습니다.");
							
							return false;
							
							//퀵현대서비스 -> 1170932384
							//현대개발 -> 5142280413
							//기존에 있는 데이터 중에서 선정이 있으면 선정으로 수정 불가하게..
							
						}if(v_yn_select=='Y'&&ds_default3.namevalue(i,"YN_SELECT") ==ds_default3.namevalue(j,"YN_SELECT")){
						
							alert("선정은 하나만 가능합니다.");
							
							return false;
							
						}
		 		 	}
		 		
				} 
		 	}
		 	
		 	
		 	
		 	
		 	
		 	if(fnSelect3_cnt==ds_default3.countrow){
		 		
		 		if(ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR")){
		 			
		 			alert("기존 데이터에서 사업자등록번호가 중복되었습니다.");
		 			
					return false;
		 			
		 		}if(v_yn_select=='Y'){
		 			
		 			alert("기존 데이터에서 선정은 하나만 가능합니다.");
		 			
					return false;
		 			
		 		}
		 		
		 	}
		 	
		 	

			var param = "v_no_estimate"			+ ds_default3.namevalue(ds_default3.rowposition,"NO_ESTIMATE") 			//견적서 번호
				        + "v_cost_cd"			+ ds_default3.namevalue(ds_default3.rowposition,"COST_CD")				//project code
				        + "v_no_ma_request"		+ ds_default3.namevalue(ds_default3.rowposition,"NO_MA_REQUEST") 		//구매의뢰서 번호
				        + "v_vend_nm"			+ ds_default3.namevalue(ds_default3.rowposition,"VEND_NM") 				//업체명, 거래처 명
				        + "v_cd_vendor"			+ ds_default3.namevalue(ds_default3.rowposition,"CD_VENDOR") 			//사업자 등록번호 
				        + "v_vd_direct"			+ ds_default3.namevalue(ds_default3.rowposition,"VD_DIRECT") 			//대표자      
				        + "v_bsns_cnd"			+ ds_default3.namevalue(ds_default3.rowposition,"BSNS_CND") 			//업태       
				        + "v_bsns_knd"			+ ds_default3.namevalue(ds_default3.rowposition,"BSNS_KND") 			//업종       
				        + "v_vd_telno"			+ ds_default3.namevalue(ds_default3.rowposition,"VD_TELNO") 			//연락처      
				        + "v_am_estimate"		+ ds_default3.namevalue(ds_default3.rowposition,"AM_ESTIMATE") 			//견적 금액    
				        + "v_choice_reason"		+ ds_default3.namevalue(ds_default3.rowposition,"CHOICE_REASON") 		//선정 사유    
				        + "v_yn_select"			+ ds_default3.namevalue(ds_default3.rowposition,"YN_SELECT") 			//신청 여부
				        ;
	
	
	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq030",
		                "JSP(I:DS_DEFAULT3=ds_default3)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>",
		                +param    
		                );
 
	                
	        tr_post(tr1);
	        		

        		
		}
    

    
    
    
    
	<%// 팝업 조회 %>
    function fnPopup() {
    	
	    	var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			
			strURL = "<%=dirPath%>/Pms/new/pur/rq031.jsp";
			strPos = "dialogWidth:500px;dialogHeight:400px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,'',strPos);
			
			if (arrResult != null) {
				
	    		arrParam = arrResult.split(";");

	    		v_request_no.value 		= arrParam[0];
	    		v_project_code.value 	= arrParam[1];
	    		v_project.value    		= arrParam[2];
	    		
	    		fnSelect();
	    		
	        }else{
	        	
	        	v_project.value    = "";
	        	v_project_code.value = "";
	    		v_request_no.value = "";
	    		
	        }
			

    }
    
		
			
			
			
			
			
		
    <%// addrow data %>
    function fnc_addRow(){

    	
    	
    	//기본 정보 list의 데이터가 없다면 검색을 하지 않은것과 동일.
    	//즉, 기본 정보 list의 데이터가 없다면 검색x
    
    		
    	ds_default3.Addrow();
    	
    	
    	//행추가시 값 달아주기
    	ds_default3.namevalue(ds_default3.RowPosition, "COST_CD")= v_project_code.value;
    	
    	ds_default3.namevalue(ds_default3.RowPosition, "NO_MA_REQUEST")= v_request_no.value;
    	
    	//ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE")= "자동채번";
    	
    	
    	if(ds_default3.countrow == 0 ||ds_default3.countrow == null ||ds_default3.countrow == "" ){

    		ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE")= "자동채번";
    		
    	}else{

    		ds_default3.namevalue(ds_default3.RowPosition, "NO_ESTIMATE") = ds_default3.namevalue(1, "NO_ESTIMATE"); 
    		
    	}
    	
		msgTxt.innerHTML=" 행이 삽입되었습니다.";		

    }
    
    
    
    
    
    

     <%// deleterow data %>
	 function fnc_deleterow() {

	    	//alert("ds_default3.countrow ==="+ds_default3.CountRow );
	    	
	    	//var ppp;
	    	
	    		
		   		if(ds_default3.countrow > 0 ) {
		   			
					//var param1;
					var i;
					
					for ( i=1;i<=ds_default3.countrow;i++){
						//alert(i+"번 째 checked : "+ds_culds.namevalue(i,"CHKD"));
						if (ds_default3.namevalue(i,"CHK") =="T"){

							if  (fnc_Appoint_Chkd(i)){

								//alert("rowPosition : "+i);
								ds_default3.DeleteRow(i);
								
								i--;
								
							}else{
								
								alert("여기 들어와?");
								
								break;
								
							}
							
						} //for
						
					}
					
	
				}else{

					alert("데이터가 존재하지 않습니다");
					
				}
		   		
		   		

    	
   		/* if(ds_culds.countrow > 0 ) {
   			//총 데이터 row 수
   			alert(ds_culds.countrow);
			alert("정말??");
			for ( i=1;i<=ds_culds.countrow;i++){
				
				if (ds_culds.namevalue(i,"CHKD") == "T"){
   			alert(ds_culds.namevalue(i,"DS_KSITEM")+"1111111");
					//alert(ds_culds.namevalue(i,"CHKD"));
					
					alert("i=========="+i);

					//fnc_Header_create();
				
					//alert("??");
					//alert(ds_culds.namevalue(i,"DS_KSITEM")+" 삭제 머머임?");
					//ds_culds.addrow();
					//ds_culds.DeleteRow(ds_culds.RowPosition);
					
					
					
					ds_culds.DeleteRow(ds_culds.RowPosition);

					prompt(this,ds_culds.text );
				}
			}

		}else{
			alert("데이터가 존재하지 않습니다");
		} */
		

	}
    
    
    
    
    
    
		function fnc_Appoint_Chkd(i){


			return true;



		}

		
		
		
    <%// 디테일 계정정보 %>
    //처리상태 - 처리에 대한 계정정보 dstype 안씀.
   <%--  function fnSelectDetail(row) {
        v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_acquire_sid="+ ds_cul.namevalue(row,"ACQUIRE_SID");
        //ACQUIRE_SID - sql테이블 컬럼 - 카드  - 내부적으로 가지고 있는 값
		ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_CC%>Cc110I",
            "JSP(O:DS_CULD=ds_culd)",
            v_param);
		tr_post(tr2);
    } --%>
    
    
    
    

    
    

    </script>
    
    
    
    

	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

	<script language="javascript" for="tr1" event="OnSuccess()">
	
	
		if(v_job=="A"){
			
			alert("성공적으로 저장되었습니다.");
			
			fnSelect();
		}
	
	</script>



		

<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>


<!-- classid 쓰면됨. -->
<object id=ds_default classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_default2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_default3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
		    <param name="KeyName"    value="toinb_dataid4"/>
		    <param name="ServerIP"   value=""/>
		    <param name="Action"     value=""/>
		    <param name="KeyValue"   value=""/>
		    <param name="Parameters" value=""/>
</object>


</head>



<jsp:include page="/Common/sys/body_s10.jsp"/>

<!--------------------------------- 코딩 부분 시작 ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
        <tr height='20px'>
            <td></td>
        </tr>
        <tr>
            <td>
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="1002px">
           			<tr>
                        <td align="center" class="text" width="150">구매의뢰서 번호</td>
                        <td align="left" bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_request_no' id="v_request_no" style="width:100px;background-color:whitesmoke;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="" readonly>
                        <img align="right"  src="<%=dirPath%>/Sales/images/help.gif"		style="cursor:pointer" 	onClick="fnPopup();">
                        <td align="center" class="text" width="150">Project</td>
                        <td align="left" bgcolor="#FFFFFF" ><input type="hidden" name='v_project_code' id="v_project_code" class='textbox'  value="">
                        <td align="left" bgcolor="#FFFFFF" ><input type="text" name='v_project' id="v_project" style="width:300px; background-color:whitesmoke;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" value="" readonly > 
					</tr>
           		</table>
            </td>
        </tr> 
        
        <tr height='20px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>[기본 정보 List]</b>
                <object id=gr_default classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='100px' border='1'>
                    <param name="DataID"            	value="ds_default">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
                    <param name="Format"            	value="
                    	<C> name='구매의뢰서 번호'		ID='NO_MA_REQUEST'			width=90 	align=CENTER  	edit=none			readonly=true 	show=false		</C>
                    	<C> name='프로젝트 코드'		ID='COST_CD'				width=90 	align=CENTER  	edit=none			readonly=true 	show=false		</C>
                    	<C> name='청구 내용'			ID='DS_MA_REQUEST'			width=300 	align=CENTER  	edit=none			readonly=true 					</C>
                    	<C> name='청구 일자'			ID='DT_MA_REQUEST'			width=100 	align=CENTER 	edit=none 			mask='XXXX-XX-XX'	readonly=true	</C>                 	
                        <C> name='납품 기간'			ID='DT_DELIVERY'			width=100 	align=CENTER 	edit=none 			mask='XXXX-XX-XX'	readonly=true	</C>
                        <C> name='인도 조건'			ID='DELIVERY_CONDITION' 	width=140 	align=CENTER	edit=none			readonly=true		</C>
                        <C> name='대금 지불 조건'		ID='PAY_CONDITION'			width=150 	align=CENTER 	edit=none			readonly=true		</C>
                        <C> name='기타 사항' 			ID='REMARK'					width=200 	align=CENTER	edit=none			readonly=true		</C>
                    	
                 ">                             
                </object>                   
            </td>
        </tr>
        
        

        <tr height='20px'>
            <td></td>
        </tr>
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>[청구 품목 List]</b>
                <object id=gr_default2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='250px' border='1'>
                    <param name="DataID"            	value="ds_default2">
                    <param name="Editable"          	value="false">
                    <param name="BorderStyle"       	value="0">  
                    <param name="ViewSummary"    		value="1">        
					<param name="ColSelect"    			value="True">
					<param name="ColSizing"         	value="true">	
                    <param name="Format"           		value="
		                <C> name='구매의뢰서 번호'   		ID='NO_MA_REQUEST'  Width=90	align=RIGHT 	show=false	DEC=0</C>
		                <C> name='코드'   					ID='CD_COST'  		Width=120	align=center	</C>                    
						<C> name='구매 의뢰 Contents'		ID='DS_KSITEM'		width=320 	align=left		edit=none	</C>
						<C> name='도급수량'    				ID='ORDER_QN'		Width=100  	align=center	show=false	edit=none	</C>
		                <C> name='도급 단가'    			ID='ORDER_UP'  		Width=100  	align=center 	show=false	edit=none	</C>
		                <C> name='도급 금액'				ID='ORDER_AMT'	    Width=100  	align=center 	show=false	edit=none	</C>
		                <C> name='실행 수량'	  			ID='EXE_ACT_QN'   	Width=100  	align=center	edit=none	DEC=0</C>
		                <C> name='실행 단가'    			ID='EXE_ACT_UP'    	Width=100  	align=center 	edit=none	DEC=0</C>
		                <C> name='실행 금액'   				ID='EXE_ACT_AMT' 	Width=100  	align=right 	edit=none	DEC=0 sumtext=@sum</C>
		                <C> name='청구 수량' 				ID='QN_ITEM'   		Width=120	align=center 	edit=none	DEC=0</C>		                
		                <C> name='청구 금액'   				ID='AM_ITEM'  	 	Width=120	align=RIGHT 	edit=none	DEC=0 sumtext=@sum</C>
			        ">
                </object>
            </td>
        </tr>        

        
        <tr height='20px'>
            <td></td>
        </tr>
        

        <tr>
            <td valign="top" style="padding-top:4px"><b>[견적 업체 List]</b>
            
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        		<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" 	onClick="fnApply();">
        		<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer"  onClick="fnc_addRow()" >
        		<img src="<%=dirPath%>/Sales/images/minus.gif"	style="cursor:pointer"  onClick="fnc_deleterow()" >
            </td>
        </tr>
            
            
		<tr>            
            <td>   
                <object id=gr_default3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='150px' border='1'>
                    <param name="DataID"            	value="ds_default3">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name=ColSelect    			value="True">
					<param name="ColSizing"         	value="true">
                    <param name="Format"            	value="
                    	<C> name='선택'					ID=CHK					width=40 	align=center 	bgcolor=#f5f5f5, EditStyle=CheckBox, cursor=hand, sort=false</C>
		                <C> name='견적서 번호'			ID='NO_ESTIMATE'		Width=170  	align=center	edit=none mask='XXXXXXXX-XXXX'</C>
                    	<C> name='업체명'    			ID='VEND_NM'			Width=250  	align=center	</C>
						<C> name='사업자 등록번호'		ID='CD_VENDOR'			width=140 	align=center	mask='XXX-XX-XXXXX'</C>
						<C> name='대표자'    			ID='VD_DIRECT'			Width=100  	align=center	show=false</C>
						<C> name='업태'    				ID='BSNS_CND'			Width=170  	align=center	show=false</C>
		                <C> name='업종'    				ID='BSNS_KND'  			Width=70  	align=center 	show=false</C>
		                <C> name='연락처'				ID='VD_TELNO'	 	    Width=170  	align=center 	show=false</C>
		                <C> name='견적 금액'	  		ID='AM_ESTIMATE'   		Width=120  	align=right		show=true	</C>
		                <C> name='선정 사유'    		ID='CHOICE_REASON'    	Width=150  	align=left  	show=true	</C>
		                <C> name='선정 여부' 			ID='YN_SELECT' 			Width=110  	align=center 	show=true	DEC=0	EditStyle=Combo		 Data=' :선택,Y:선정,N:탈락'</C>
		                <C> name='Project Code' 		ID='COST_CD' 			Width=110  	align=center 	show=false	DEC=0</C>
		                <C> name='구매의뢰서 번호' 		ID='NO_MA_REQUEST' 		Width=110  	align=center 	show=false	DEC=0</C>
			        ">
                </object>
            </td>
        </tr>



        
    </table>
    
</body>

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>




