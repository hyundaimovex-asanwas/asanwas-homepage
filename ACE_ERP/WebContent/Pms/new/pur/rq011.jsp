<!-- /******************************************************************************
 * 시스템명 	 : 구매의뢰서 - 상세보기
 * 프로그램ID 	 : PMS/RQ010
 * J  S  P	 	 : rq011.jsp
 * 서 블 릿		 : 
 * 작 성 자		 : 김도연
 * 작 성 일		 : 2018-05-30
 * 기능정의		 : 구매의뢰서 - 상세보기
 * [ 수정일자 ][수정자] 내용
 * [ 2018-06-05 ][김도연] 신규개발

 *****************************************************************************/ -->

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
	//최초 tree_idx
	int tree_idx = 0;
    SmartRequest sr = new SmartRequest(request);	
    tree_idx = sr.getInt("idx");    //받아온 현재 메뉴 값! fnOnLoad() 함수에 파라미터로 전달하여 메뉴구성!

%>


<!-- HTML 시작 : doctype를 html5로 해볼까? 훔;;-->
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


	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var v_status = ""; //S:조회, I:초기, N:신규, SD:디테일조회, A:적용  v_status
	
	var menuWin;	//새창 띄우기용.
	
	var arrParam	= new Array();
	
  	arrParam=window.dialogArguments;

    var no_ma_request = arrParam[0];	//구매의뢰서 번호
    
    var cost_cd = arrParam[1];			//Project Code
    
    var plj_nm = arrParam[2];			//Project Nmae

    
    
	/*
	 * 페이지로딩
	 */
		
	function fnOnLoad(tree_idx){
			
			document.getElementById("v_request_no").value = no_ma_request;		//구매의뢰서 번호
			document.getElementById("v_project").value = plj_nm;				//Project Nmae
			document.getElementById("v_project_code").value = cost_cd;			//Project Code

			cfStyleGrid(getObjectFirst("gr_cul"), "comn");	//card usage list
			cfStyleGrid(getObjectFirst("gr_culd"), "comn");	//card usage list detail
			
			fnSelect();
			
	}
		
    
    
	    <%//초기작업 %>
	    function fnInit() {
	    	

	
	    }
	    
    
	    
    
    
	    <%//메인 조회 %>
	    function fnSelect() {
	    	
	    	v_job = "S";
	
	    	//alert(v_job);
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									+ ",v_project_code=" + v_project_code.value	//Project Code
									+ ",v_request_no=" + v_request_no.value		//Project Code
									;
	
	        
	        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_MASTER=ds_master)", //화면 출력. o ->output
		            param);
	        
	        tr_post(tr1);
	        
	        
	        
	        
	        ln_TRSetting(tr2, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_DETAIL=ds_detail)", //화면 출력. o ->output
		            param);
	        
	        tr_post(tr2);	        
	        
	        //fnSelectDetail('1');
	
	    }
	    
	        
    
    
	    
    
		<%//저장 %>
		function fnApply(){
			
			v_job = "A";
			
			//v_default_row = ds_detail.RowPosition;

			var s_temp = "NO_MA_REQUEST:STRING, SN_NO:DECIMAL, CD_COST:STRING, DS_ITEM:STRING, QN_ITEM:STRING, UP_ITEM:STRING, AM_ITEM:STRING";
			
			ds_detail2.SetDataHeader(s_temp);

	 		ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		                "JSP(I:DS_DETAIL2=ds_detail2)",
		                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
	                	);
		 	
		 	
		 	
		 			//alert("assa");
	        		//prompt(this, param);
	        		
	        		//데이터 셋 ...ㅠㅠㅠㅠㅠㅠㅠ
					//var	pppp =  parseInt(ds_detail.namevalue(1,"REQUEST_QN")) * parseInt(ds_detail.namevalue(1,"EXE_ACT_AMT"));
					
					//alert(pppp);
					
					//ds_detail.namevalue(ds_detail.rowposition,"AM_ITEM") = pppp  ; //청구 금액 - 청구수량 * 실행금액
					//ds_detail.namevalue(j,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ; //구매의뢰서 번호
					//ds_detail.namevalue(j,"ORDER_UP") = ds_master.namevalue(i,"ORDER_UP") ;     				//도급 단가
					//ds_detail.namevalue(j,"EXE_ACT_UP"  ) = ds_master.namevalue(i,"EXE_ACT_UP") ;  			//실행 단가
					//ds_detail.namevalue(j,"ALREADY_QN"  ) = ds_master.namevalue(i,"ALREADY_QN") ; 				//기청구 수량
	        		
	        		
					//  이동훈 
		            for(i=1;i<=ds_detail.countrow;i++){

		            	if(ds_detail.SysStatus(i)==1){
			            	
			            	ds_detail2.addrow();
			            	
			                ds_detail2.namevalue(ds_detail2.rowposition,"NO_MA_REQUEST") = ds_detail.namevalue(i,"NO_MA_REQUEST");
			                ds_detail2.namevalue(ds_detail2.rowposition,"SN_NO") 		 = ds_detail.namevalue(i,"SN_NO");
			                
			                ds_detail2.namevalue(ds_detail2.rowposition,"CD_COST") 		 = ds_detail.namevalue(i,"CD_COST");
			                ds_detail2.namevalue(ds_detail2.rowposition,"DS_ITEM") 		 = fn_trim(ds_detail.namevalue(i,"DS_ITEM"));
			                ds_detail2.namevalue(ds_detail2.rowposition,"QN_ITEM") 		 = ds_detail.namevalue(i,"REQUEST_QN")
			                ds_detail2.namevalue(ds_detail2.rowposition,"UP_ITEM") 		 = ds_detail.namevalue(i,"EXE_ACT_UP");
			                ds_detail2.namevalue(ds_detail2.rowposition,"AM_ITEM") 		 = parseInt(ds_detail.namevalue(i,"REQUEST_QN")) * parseInt(ds_detail.namevalue(i,"EXE_ACT_UP"));

		            	}else if(ds_detail.SysStatus(i)==3){
		            		
		            		alert("여긴 업데이트");

		            	}
		            	
		            	
		            	
		                //SysStatus  1 = insert , 3 = update
		                //if(ds_detail.SysStatus(i)==1||ds_detail.SysStatus(i)==3){
		                	
		                  	//ds_detail.namevalue(i,"AM_ITEM") = parseInt(ds_detail.namevalue(i,"REQUEST_QN")) * parseInt(ds_detail.namevalue(i,"EXE_ACT_AMT"));
			                //ds_detail.namevalue(i,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ;    //구매의뢰서 번호
			                //ds_detail.namevalue(i,"SN_NO")           = ds_master.namevalue(i,"ORDER_UP") ;                 //도급 단가
			                //ds_detail.namevalue(i,"CD_COST"  )     = ds_master.namevalue(i,"CD_COST") ;              //실행 단가
			                //ds_detail.namevalue(i,"ALREADY_QN"  )  = ds_master.namevalue(i,"ALREADY_QN") ;             //기청구 수량                       
			               
		              	//}
		             
		        	}
					
					
					
		       		//청구 > 실행수량
				 	if(ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN") > ds_detail.namevalue(ds_detail.rowposition,"EXE_ACT_QN")){
				 		
				 		alert("실행수량 보다 청구수량이 많습니다");
				 		
				 		return ;
				 		
				 	} 
					
		       		
	        		
	                //prompt(this, ds_detail2.text);
	                
	                //alert("값 === "+v_cost_cd+v_nm_request + v_ds_ma_request +v_ty_buytype +v_remark);
	                
	        		tr_post(tr1);
	        		

	    			fnSelect();
	    			

		}
	    
	


     <%//addrow data %>
	 function fnc_addarrow() {
    	
		//fnSelectDetail();
		fnSelectDetail('1');
    	//alert("ds_master.countrow ==="+ds_master.CountRow );
    	
    	var j = 0;
    	
   		if(ds_master.countrow > 0 ) {
   			
			var param1;

			
			if(ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN")==""){

				param1 = "";
				
			}else{

				param1 = ds_detail.namevalue(ds_detail.rowposition,"REQUEST_QN");
				
			}

			
			for ( i=1;i<=ds_master.countrow;i++){
				
				if (ds_master.namevalue(i,"CHK") =="T"){
					
					if  (fnc_Appoint_Chk(i)){

									//fnSelectDetail(i);
									
									ds_detail.addrow();

									//j = j + 1;

									j = ds_detail.countrow;

									
									ds_detail.namevalue(j,"NO_MA_REQUEST") = document.getElementById("v_request_no").value ; 	//구매의뢰서 번호
									ds_detail.namevalue(j,"DS_ITEM") = fn_trim(ds_master.namevalue(i,"DS_KSITEM")) ;       		//구매 의뢰 Contents
									ds_detail.namevalue(j,"CD_COST") = ds_master.namevalue(i,"CD_COST") ;  						//상세분류코드(공통코드)
									ds_detail.namevalue(j,"ORDER_QN") = ds_master.namevalue(i,"ORDER_QN") ;       				//도급 수량
									ds_detail.namevalue(j,"ORDER_AMT"  ) = ds_master.namevalue(i,"ORDER_AMT") ;  				//도급 금액
									ds_detail.namevalue(j,"EXE_ACT_QN"  ) = ds_master.namevalue(i,"EXE_ACT_QN") ;  				//실행 수량
									ds_detail.namevalue(j,"EXE_ACT_AMT"  ) = ds_master.namevalue(i,"EXE_ACT_AMT") ; 			//실행 금액
									ds_detail.namevalue(j,"ALREADY_AMT"  ) = ds_master.namevalue(i,"ALREADY_AMT") ; 			//기청구 금액
									ds_detail.namevalue(j,"ORDER_UP") = ds_master.namevalue(i,"ORDER_UP") ;     				//도급 단가
									ds_detail.namevalue(j,"EXE_ACT_UP"  ) = ds_master.namevalue(i,"EXE_ACT_UP") ;  				//실행 단가
									ds_detail.namevalue(j,"ALREADY_QN"  ) = ds_master.namevalue(i,"ALREADY_QN") ; 				//기청구 수량 */
									ds_detail.namevalue(j,"REQUEST_QN"  ) = param1; 											//청구

					}else{
						
						break;
						
					}
					
				} //for
				
			}

			
		}else{
			
			alert("데이터가 존재하지 않습니다");
			
		}
		

	}
    

	 
  	<%//addrow data check %>	 
	function fnc_Appoint_Chk(i){

		if(ds_master.namevalue(i,"COST_YN") != "Y"){
			
			alert("최종 아이템에 대한 청구만 가능합니다.");
			
			return ;
			
		}		
		
		if(ds_master.namevalue(i,"EXE_ACT_QN") == "0"){
			
			alert("실행 수량을 확인하시기 바랍니다.");
			
			return ;
			
		}

		if(ds_master.namevalue(i,"NOTYET_QN") == "0"){
			
			alert("청구 가능한 수량이 없습니다.");
			
			return ;
			
		}
		
		
		for (i=1; i<=ds_detail.countrow; i++){
			

			if(ds_detail.namevalue(i,"CD_COST") == ds_master.namevalue(ds_master.rowposition,"CD_COST")){
				
				alert("선택된 품목이 중복됩니다.\n\n해당 품목에 대한 수량 업데이트를 하시기 바랍니다.");
				
				return ;
				
			}
			
		}
			
		
		return true;

	}
	 
	 
	 
	 
     <%//deleterow data %>	 
	 function fnc_deleterow() {
		 
		    	//alert("ds_detail.countrow ==="+ds_detail.CountRow );
		    	
		    	//var ppp;
		    	
		   		if(ds_master.countrow > 0 ) {
		   			
					//var param1;
					var i;
					
					for ( i=1; i<=ds_detail.countrow; i++){
						
						//alert(i+"번 째 checked : "+ds_detail.namevalue(i,"CHKD"));
						
						if (ds_detail.namevalue(i,"CHKD") =="T"){
							
							if  (fnc_Appoint_Chkd(i)){
								
								//alert("rowPosition : "+i);
								ds_detail.DeleteRow(i);
								
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
		 
		 
	    	
	   		/* if(ds_detail.countrow > 0 ) {
	   			//총 데이터 row 수
	   			alert(ds_detail.countrow);
				alert("정말??");
				for ( i=1;i<=ds_detail.countrow;i++){
					
					if (ds_detail.namevalue(i,"CHKD") == "T"){
	   			alert(ds_detail.namevalue(i,"DS_KSITEM")+"1111111");
						//alert(ds_detail.namevalue(i,"CHKD"));
						
						alert("i=========="+i);

						//fnc_Header_create();
					
						//alert("??");
						//alert(ds_detail.namevalue(i,"DS_KSITEM")+" 삭제 머머임?");
						//ds_detail.addrow();
						//ds_detail.DeleteRow(ds_detail.RowPosition);
						
						
						
						ds_detail.DeleteRow(ds_detail.RowPosition);

						prompt(this,ds_detail.text );
					}
				}

			}else{
				alert("데이터가 존재하지 않습니다");
			} */
			

		}

	 
	 

	
	
	

	
	  	<%//deleterow data check %>
		function fnc_Appoint_Chkd(i){
	
				return true;
	
		}
		
		
		
	

    <%// 디테일 정보 %>
	
    //처리상태 - 처리에 대한 계정정보 dstype 안씀.
    
    function fnSelectDetail(row) {
    	
    	//alert("18");
    	
        //v_default_row = row;//이번에 디테일을 조회하는 row를 담아두고 감
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
							        + ",v_project_code="+ v_project_code.value	//프로젝트 코드
							        + ",v_request_no="+ v_request_no.value
							        ;	
		
        
        //ACQUIRE_SID - sql테이블 컬럼 - 카드  - 내부적으로 가지고 있는 값
		ln_TRSetting(tr2, 
		            "<%=dirPath%><%=HDConstant.PATH_PUR%>Rq011",
		            "JSP(O:DS_DETAIL=ds_detail)",
		            v_param);
        
		//alert(v_param);
        
		tr_post(tr2);
		
		
    }
    
    

    </script>
    
    
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=gr_cul event=OnClick(Row,Colid)>
	
	/* var zzzz1		=	ds_master.namevalue(ds_master.rowposition,"EXE_ACT_QN");
    alert(zzzz1); */
    
		v_job="SD"; //디테일 조회
		
	    if(Row==0) return;
		
	    if(v_default_row==Row){
	    	
			return;
		}

	</script>	
	
	
	
	<!----------------------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직 ds_master |
    +----------------------------------------------------------------->
    <Script For=ds_detail Event="OnLoadCompleted(iCount)">

    </Script>
    
    
    
    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=ds_master Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>



    <Script For=ds_detail Event="OnLoadError()">
        cfErrorMsg(this);
    </Script>
    
    
    



	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">

		/* fnc_Message(document.getElementById("resultMessage"), 'MSG_01');
		ds_master.ClearAll();
		ds_detail.ClearAll();    
		fnc_SearchList(); */
		
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>

<script language=JavaScript  for=ds_master event="OnLoadCompleted(row)">
  
      	msgTxt.innerHTML="조회가 완료 되었습니다.";
      
      	/*
		if(v_job=="S"){
			
			if(row==0){
				
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
		        
			}else{
				
				fnSelectDetail(v_default_row);
				
			}
			
		}*/

</script>
    	
    

<!-- 마우스 이벤트 - 더블클릭 - 로우 ,아이디 -->
<script language=javascript for=gr_cul event="OnDblClick(Row,Colid)">

 	//alert(ds_cul.NameValue(Row, "DWR_SID"));
 	fnDraft(ds_master.NameValue(Row, "DWR_SID"),ds_master.NameValue(Row, "W_STS"));
 	
</script>	
	
	

    	
    
    
<%
/*=============================================================================
			DataSet Components(DS) 선언
=============================================================================*/
%>

<!-- classid 쓰면됨. -->
<object id=ds_master classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>


<object id=ds_detail classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>


<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>



</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s11.jsp"/>
<!-- //body_s.jsp -->


<!--------------------------------- 코딩 부분 시작 ------------------------------->	

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td class="paddingTop5">
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td valign="bottom" class="searchState" width="10%"><span id="resultMessage">&nbsp;</span></td>
                </tr>
            </table>
        </td>
    </tr>
</table>



<!-- 조회 상태 테이블 끝 -->
    <table border='0' cellpadding='0' cellspacing='0'> 

        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width="99%">
           			<tr>
           				<td align="center" class="text" width="90">Project</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;
	                  		<input type="text" id="v_project_code" 	name='v_project_code'  	style="width:100px;" class='textbox'  value="">                 		
	                  		<input type="text" id="v_project" 		name='v_project'  		style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">
                  		<td align="center" class="text" width="90">구매의뢰서 번호</td>
                  		<td bgcolor="#FFFFFF" >&nbsp;<input type="text" id="v_request_no" name='v_request_no'  style="width:200px;" class='textbox'  onkeydown="if(event.keyCode==13) fnSelect();" readonly value="">                             
					</tr>
           		</table>
            </td>
        </tr> 
        
        
        <tr height='10px'>
            <td></td>
        </tr>
        
        
        <tr>
            <td valign="top" style="padding-top:4px"><b>&nbsp;&nbsp;[전체 실행 List]</b></td>
        </tr>
        
		<tr>            
            <td class="r">&nbsp;&nbsp;&nbsp;
                <object id=gr_cul classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='300px' border='1'>
                    <param name="DataID"            	value="ds_master">
                    <param name="Editable"          	value="true">
                    <param name="BorderStyle"       	value="0">
                    <param name="SuppressOption"    	value="1">
					<param name="ColSelect"    			value="True">
					<param name="ColSizing"         	value="true">																								                                        
					<param name="Format"            	value="
						<C> Name='선택'					ID=CHK					width=40 		align=center 	EditStyle=CheckBox, cursor=hand edit={IF(chk2=F,'false','true')}</C>
            			<C> name='NO'					id='{CUROW}'			width=40		align=center	value={String(Currow)}	show=false</C>
						<C> name='Contents'				ID='DS_KSITEM'			width=300 		align=left  	edit=none </C>
						<C> name='ITEM'    				ID='COST_YN' 			Width=50  		align=center 	edit=none </C>
						<C> name='도급 수량'    		ID='ORDER_QN' 			Width=100  		align=left 		edit=none show=false 	</C>
		                <C> name='도급 단가'    		ID='ORDER_UP'  			Width=100  		align=center  	edit=none show=false 	</C>
		                <C> name='도급 금액'			ID='ORDER_AMT'	    	Width=100  		align=center 	edit=none show=false 	</C>
		                <C> name='실행수량'	  			ID='EXE_ACT_QN'   		Width=60  		align=center  	edit=none value={decode(COST_YN,'',,'Y',EXE_ACT_QN, )}</C>
		                <C> name='실행단가'    			ID='EXE_ACT_UP'    		Width=90  		align=RIGHT  	edit=none value={decode(COST_YN,'',,'Y',EXE_ACT_UP, )}</C>
		                <C> name='실행금액'   			ID='EXE_ACT_AMT' 		Width=110  		align=RIGHT 	DEC=0 edit=none</C>
		                <C> name='기청구수량' 			ID='ALREADY_QN'   		Width=80		align=center 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',ALREADY_QN, )}</C>
		                <C> name='기청구금액'  			ID='ALREADY_AMT'  		Width=80  		align=RIGHT 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',ALREADY_AMT, )}</C>
		                <C> name='미청구잔량'   		ID='NOTYET_QN'   		Width=80		align=center 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',NOTYET_QN, )}</C>
		                <C> name='미청구금액'   		ID='NOTYET_AMT'   		Width=80		align=RIGHT 	DEC=0 edit=none value={decode(COST_YN,'',,'Y',NOTYET_AMT, )}</C>
		                <C> name='구매의뢰서 번호'   	ID='NO_MA_REQUEST'  	Width=90		align=RIGHT 	show=false	DEC=0 edit=none</C>
		                <C> name='청구' 	 			ID='REQUEST_QN'  		Width=90  		align=RIGHT 	show=false	DEC=0 edit=none</C>
		                <C> name='Projcet Code'   		ID='COST_CD'   			Width=90		align=RIGHT 	show=false	DEC=0</C>
		                <C> name='Projcet Code'   		ID='CD_COST'   			Width=90		align=RIGHT 	show=false </C>		                
			        ">                       
                </object>                        
            </td>
        </tr>
        
        
        <!-- 버튼 테이블 시작 -->
		<table width="1000" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td height="35" width="1000" class="paddingTop5" align="center" >
		            <a href="#" ><img src="<%=dirPath%>/Sales/images/addrow_1.gif" 		name="Image1" width="40" height="20" border="0" align="absmiddle" onClick="fnc_addarrow()"></a>
		            <a href="#" ><img src="<%=dirPath%>/Sales/images/deleterow_1.gif" 	name="Image1" width="40" height="20" border="0" align="absmiddle" onClick="fnc_deleterow()"></a>
				</td>
			</tr>
		</table>
		
        <tr>
            <td valign="top" style="padding-top:4px"><b>&nbsp;&nbsp;[청구 품목 List]</b></td>
            
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

            <td height='20px' align='right'>
            	<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" 	onClick="fnApply();">
            </td>
        </tr>
        
		<tr>            
            <td class="r">&nbsp;&nbsp;&nbsp;            
                <object id=gr_culd classid=<%=HDConstant.MxGrid_CLSID_S%> width='1000px' height='300px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="Editable"          value="true">
                    <param name="BorderStyle"       value="0">                 
                    <param name="SuppressOption"    value="1">
                    <Param Name="AllShowEdit"  		value=True>
					<param name="ColSelect"    		value="True">
					<param name="ColSizing"         value="true">	
                    <param name="Format"            value="
						<C> name='NO'					id='SN_NO'			width=40	align=center	value={String(Currow)}</C>
						<C> name='코드'    				ID='CD_COST'		Width=130  	align=center	edit=none	</C>						
						<C> name='구매 의뢰 Contents'	ID='DS_ITEM'		width=250 	align=left			</C>
						<C> name='도급수량'    			ID='ORDER_QN'		Width=60  	align=center	edit=none show=false</C>
		                <C> name='도급 단가'    		ID='ORDER_UP'  		Width=100  	align=center 	edit=none show=false</C>
		                <C> name='도급 금액'			ID='ORDER_AMT'	    Width=100  	align=center 	edit=none show=false</C>
		                <C> name='실행 수량'	  		ID='EXE_ACT_QN'   	Width=80  	align=center	edit=none   DEC=0</C>
		                <C> name='실행 단가'    		ID='EXE_ACT_UP'    	Width=80  	align=RIGHT 	edit=none   DEC=0</C>
		                <C> name='실행 금액'   			ID='EXE_ACT_AMT' 	Width=100  	align=RIGHT 	edit=none	DEC=0</C>
		                <C> name='기청구 수량' 			ID='ALREADY_QN'   	Width=100	align=center 	edit=none	DEC=0</C>
		                <C> name='기청구 금액' 			ID='ALREADY_AMT'   	Width=100	align=RIGHT 	edit=none	DEC=0</C>
		                <C> name='청구' 	 			ID='REQUEST_QN'  	Width=90  	align=center 	</C>
		                <C> name='구매의뢰서 번호'   	ID='NO_MA_REQUEST'  Width=90	align=RIGHT 	show=false		DEC=0</C>
		                <C> name='청구 금액'   			ID='AM_ITEM'  	 	Width=90	align=RIGHT 	show=false		DEC=0</C>
			        ">                       
                </object>
            </td>
        </tr>
    </table>
    

<!--------------------------------- 코딩 부분 끝 -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>


