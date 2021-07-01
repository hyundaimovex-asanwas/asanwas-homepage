<!--
    ******************************************************************
    * @Source              : item010.jsp                             *
    * @Description         : 품목코드관리                            *
    * @Font                :                                         *
    * @Developer Desc      :                                         *
    *******************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION                          *
    *-------------+-----------+-------------------------------------+
	* 2018/06/11            이동훈            				         *
    *******************************************************************
-->

<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
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

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >


	var v_default_row = 1; //디폴트 데이터셋의 1행. 디테일 데이터셋을 조회하기 위함
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	var menuWin;	//새창 띄우기용.
	
	
	
	/*
	 * 페이지로딩
	 */
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출

		cfStyleGrid(getObjectFirst("grd_ITEM_D"), "comn");	//list detail

		fnInit();
		
	}
	
	
	
	
    <%//초기작업 %>
    function fnInit() {
    	
	    v_job ="I";
        
		//데이터셋 헤더 초기화 = 빈 조회
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
            "JSP(O:DS_ITEM_M=ds_item_m)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>");
		
        tr_post(tr1);


    }

    
    
    
    <%//메인 조회 %>
    function fnSelect() {

    	v_job="S";

    	/* protype = select , v_site_sid ,  */
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_code=" + txtCOMM_CD_SHR.value				//코드명 , 검색조건
						;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
            "JSP(O:DS_ITEM_M=ds_item_m)", //화면 출력. o ->output
            v_param);

        
        tr_post(tr1);

    }    
    



 		<%//저장 %>         
        function fnSave() {
        	
			var f = document.form1;
			
			if(fnc_SaveItemCheck()) {
				
				tr01T_CM_COMMON.KeyValue = "SVL(I:ds01T_CM_COMMON=ds01T_CM_COMMON)";
				tr01T_CM_COMMON.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.cod.b.codb010.cmd.CODB010CMD&S_MODE=SAV";
				tr01T_CM_COMMON.post();
				

	            dsT_CM_COMMON.Reset();

	            ds01T_CM_COMMON.Reset();
	            
			} else {
				
				return;
				
			}
        }





		<%//신규 생성 %>
	      function fnAddNew() {
	
	          // AddNew 후 입력 테이블로 포커스
	          ds_ITEM_D.AddRow();
	
	          ds_ITEM_D.NameValue(ds_ITEM_D.RowPosition,"DT_APPLY") = "<%=DateUtil.getCurrentDate(8)%>";
	          
	
	      }




        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {
        	
   			var f = document.form1;

			//DataSet의 변경 여부 확인
			if (!ds01T_CM_COMMON.IsUpdated ) {
				fnc_Message(document.getElementById("resultMessage"), "MSG_04");
		    	return false;
			}

			var i = 0;
			
			var oCD_GBN, oCOMM_CD, oCOMM_NM, oSORT_NO, oEND_YMD;
			
			var RowCnt = ds01T_CM_COMMON.CountRow;
			
			
			for(i=1; i<=RowCnt; i++){

				oCD_GBN = ds01T_CM_COMMON.NameValue(i,"CD_GBN");
				if(oCD_GBN.trim() == ""){
					alert(i+"번째의 공통구분코드가 잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCD_GBN").focus();
					return false;
				}

				oCOMM_CD = ds01T_CM_COMMON.NameValue(i,"COMM_CD");
				if(oCOMM_CD.trim() == ""){
					alert(i+"번째의 코드가 잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_CD").focus();
					return false;
				}

				oCOMM_NM = ds01T_CM_COMMON.NameValue(i,"COMM_NM");
				if(oCOMM_NM.trim() == ""){
					alert(i+"번째의 코드명이 잘못되었습니다." );
					ds01T_CM_COMMON.RowPosition = i;
					document.getElementById("txtCOMM_NM").focus();
					return false;
				}


			}

			return true;
        }



</script>





    <!--**************************************************************************************
    *                                                                                         *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요)  *
    *                                                                                         *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                            |
    | 2. 이름 : ds_ITEM_M,    ds_ITEM_D            |
    +----------------------------------------------->
    
	<object id=ds_ITEM_M classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>
	
	<object id=ds_ITEM_D classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
	    <param name="SyncLoad"  value="false"/>
	</object>


	<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
	    <param name="KeyName"    value="toinb_dataid4"/>
	    <param name="ServerIP"   value=""/>
	    <param name="Action"     value=""/>
	    <param name="KeyValue"   value=""/>
	    <param name="Parameters" value=""/>
	</object>



    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->


	<%//마스터 그리드 OnClick %>
	<script language="javascript"  for=tree_ds_ITEM_M event=OnClick()>

	
		var overId1 = "CD_ITEM";
		var overId2 = "TREE_LEVEL";
		var overNm = tree_ds_ITEM_M.ItemText;
		var Row = ds_ITEM_M.NameValueRow("DS_KSITEM",overNm);
		var overValue1 = ds_ITEM_M.NameValue(Row,overId1);
		var overValue2 = ds_ITEM_M.NameValue(Row,overId2);
		
		overValue2 = parseInt(overValue2)+1;
		
		//alert("overNm : "+overNm+", Row : "+Row+", overValue1 : "+overValue1+", overValue2 : "+overValue2);
		
		
    	v_job="S";

        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						+ ",v_overValue1=" + overValue1							//코드명
						+ ",v_overValue2=" + overValue2							//Tree Level					
						;

        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_ITM%>Itm010",
		            "JSP(O:DS_ITEM_D=ds_item_d)", 						
		            v_param);

        
        tr_post(tr1);


	</script>



<script language=JavaScript  for=ds_ITEM_M event=OnLoadCompleted(row)>

		//alert(row);
	
		if(row>0){

			tree_ds_ITEM_M.focus();

			tree_ds_ITEM_M.ExpandLevel = '2';

			tree_ds_ITEM_M.index = 3;	


        }
		
</script>




    <!-----------------------------+
    | Transaction Successful 처리      |
    +------------------------------>
    <script for=tr1 event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>


    <!--------------------------+
    | Transaction Failure 처리       |
    +--------------------------->
    <script for=tr1 event="OnFail()">
        cfErrorMsg(this);
    </script>



</head>
<!--
**************************************************************
* BODY START
**************************************************************
-->


<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
        	<img src="<%=dirPath%>/Sales/images/refer.gif"			style="cursor:pointer" onclick="fnSelect()">
        	<img src="<%=dirPath%>/Sales/images/n_create.gif"		style="cursor:pointer" onclick="fnAddNew()">
        	<img src="<%=dirPath%>/Sales/images/save.gif"			style="cursor:pointer" onclick="fnSave()">	
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<!-- 왼쪽 화면 시작-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  class="r">
						<!-- power Search테이블 시작 -->
						<table width="300" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td>
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<colgroup>
											<col width="100"></col>
											<col width=""></col>
											<col width="60"></col>
										</colgroup>
										<tr>
											<td align="center" class="text">코드/코드명</td>
											<td align="center">
												<input name="txtCOMM_CD_SHR" style="width 100%;" class="divInput" onKeypress="javascript:if(event.keyCode==13)fnc_SearchList()"></td>
											<td align="left"></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<!-- power Search테이블 끝 -->


						<!-- 내용 조회 Tree 시작-->
						<table width="300" height = "600" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td>
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <object id="tree_ds_ITEM_M" classid=<%=HDConstant.MxTree_CLSID_S%> style="width:300px;height:600px;">
						                            <param name="DataID"					value="ds_item_m">
													<param name=TextColumn					value="DS_KSITEM">
													<param name=LevelColumn					value="TREE_LEVEL">
													<param name=ExpandLevel					value="0">
													<param name=BorderStyle  				value="2">													
						                        </object>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- 내용 조회 Tree 끝-->

					</td>
				</tr>
			</table>
			<!-- 왼쪽 화면 끝-->
		</td>
		<td>
			<!-- 오른쪽 화면 시작-->
			<table width="690" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- 내용 조회 그리드 테이블 시작-->
						<table width="690" height = "620" border="0" cellspacing="0" cellpadding="0">
						    <tr>
								<td class="paddingTop8">
						            <table border="0" cellspacing="0" cellpadding="0">
						                <tr align="center">
						                    <td>
						                        <object id="grd_ITEM_D" classid=<%=HDConstant.MxGrid_CLSID_S%>" style="width:690px;height:620px;">
						                            <param name="DataID"						value="ds_item_d">
						                            <param name="EdiTABLE"						value="true">
						                            <param name="DragDropEnable"				value="true">
						                            <param name="SortView"						value="Left">
						                            <param name="VIEWSUMMARY"					value=0>
						                            <param name="Format"						value="
						                                <C> id='CURROW'		width=80		name='NO'			align=center		value={String(Currow)}	</C>
						                                <C> id='CD_ITEM'	width=100		name='코드'			align=center 								</C>
						                                <C> id='DS_KSITEM'	width=300		name='코드명'		align=left				                    </C>
						                                <C> id='AMT_ITEM'	width=100		name='기준단가'		align=center	    decao = 0				</C>
						                                <C> id='DT_APPLY'	width=100		name='적용일'		align=center	    mask = 'XXXX-XX-XX'		</C>						                                
						                            ">
						                        </object>
						                    </td>
						                </tr>
						            </table>
						        </td>
						    </tr>
						</table>
						<!-- 내용 조회 그리드 데이블 끝-->

					</td>
				</tr>
			</table>
			<!-- 오른쪽 화면 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->

<!-- Validation Init  -->
<jsp:include page="/common/CommonValid.jsp" flush="true">
   <jsp:param name="INIT"    value="true"/>
   <jsp:param name="FORM"    value="default"/>
</jsp:include>

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 

