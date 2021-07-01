<!--
    ************************************************************************************
    * @Source         : piri010.jsp
    * @Description    : 팀별인원명부
    * @Font           :
    * @Developer Desc :
    ************************************************************************************
    * DATE        |  AUTHOR   | DESCRIPTION
    *-------------+-----------+--------------------------------------------------------+
	* 2016/04/28            이동훈            	ERP 이사							   *
    ************************************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>



<html>
<head>
<title>팀별인원명부</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

<!--
******************************************************
* 자바스크립트 함수 선언부분
******************************************************
-->
<script language="javascript" >



        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

			var check1 = '';
			var check2 = '';
			var check3 = '';
			var check4 = '';
			var check5 = '';

			var end_yn = document.form1.rdoEND_YN_SHR.CodeValue;

			dsT_CM_PERSON.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_01&END_YN="+end_yn;
			dsT_CM_PERSON.reset();

        }

		/***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

        }

        /******************
         * 03. 저장 함수  *
         ******************/
        function fnc_Save() {

        }

        /******************
         * 04. 삭제 함수  *
         ******************/
        function fnc_Delete() {

        }

        /******************
         * 05. 인쇄 함수  *
         ******************/
        function fnc_Print() {

        }

        /***********************
         * 06. 엑셀 저장 함수  *
         ***********************/
        function fnc_ToExcel() {

        }

        /******************
         * 07. 신규 함수  *
         ******************/
        function fnc_AddNew() {

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {

			dsT_CM_PERSON.ClearData();
			dsT_CM_PERSON2.ClearData();
			document.form1.rdoEND_YN_SHR.CodeValue = "1";
			document.getElementById("resultMessage").innerText = ' ';
        }

        /************************
         * 11. 화면 종료(닫기)  *
         ***********************/
        function fnc_Exit() {

        	window.close();

        }

        /******************************
         * 12. 검색 조건 유효성 검사  *
         ******************************/
        function fnc_SearchItemCheck() {

			var check = "N";

			for(i=0;i<checkList.length;i++){
				if(checkList[i].checked == true){
					check = "Y";
				}
			}



        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			var f = document.form1;

            //Grid Style 적용
			cfStyleGrid_New(form1.grdT_CM_PERSON,0,"false","false");
			cfStyleGrid_New(form1.grdT_CM_PERSON2,0,"true","true");


			f.rdoEND_YN_SHR.CodeValue = "1";

            fnc_SearchList();

            
        }

		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

        /********************************************************
         * 이 후 모든 폼에서 필요한 함수를 정의해서 사용하세요  *
         *******************************************************/

</script>
</head>

    <!--**************************************************************************************
	*																						 *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
	*																						 *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회용 DataSet                             |
    | 2. 이름 : dsT_CM_PERSON                       |
    | 3. Table List : T_CM_PERSON                   |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름 : dsT_CM_PERSON2                      |
    | 3. Table List : T_CM_PERSON2                  |
    +----------------------------------------------->
    <Object ID="dsT_CM_PERSON2" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_CM_PERSON_DUTY" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        	Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">
        if (iCount < 1)    {
	        fnc_Message(document.getElementById("resultMessage"), "MSG_02");
        } else {
			var cnt = 0;
			for(i=1;i<iCount+1;i++){
				cnt = cnt + dsT_CM_PERSON.NameValue(i,'ENO_CNT');
			}
	        document.getElementById("resultMessage").innerText = "  총 "+iCount+"개 팀, "+cnt+"명";
        }
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadCompleted(iCount)">

    </Script>

    <!---------------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직      |
    +---------------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnLoadError()">
        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);
        // 에러 메세지 처리 후 다음 처리 할 내용 코딩
    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">
        //Dataset관련 Error 처리
        cfErrorMsg(this);
    </Script>

    <Script For=dsT_CM_PERSON2 Event="OnDataError()">

        document.getElementById("resultMessage").innerText = ' ';
        //Dataset관련 Error 처리
		cfErrorMsg(this);

    </Script>

	<!---------------------------------+
    | 다른 Radio Button을 선택한 경우  |
    +------ --------------------------->
	<script language=JavaScript for=rdoEND_YN_SHR event=OnSelChange()>

		if(dsT_CM_PERSON2.CountRow>1){
			dsT_CM_PERSON2.ClearData();
		}
		fnc_SearchList();

	</script>


    <!------------------------------+
    | 왼쪽 grid에서 row를 클릭했을때 |
    +------ ------------------------>
	<script for=grdT_CM_PERSON event=OnClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );
		
		var end_yn = document.form1.rdoEND_YN_SHR.CodeValue;
		
		if(Row < 1) {
			
			return;
			
		} else {
			
			try {
				dsT_CM_PERSON2.DataID = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_02&END_YN="+end_yn+"&DPT_CD="+dsT_CM_PERSON.NameValue(Row,'DPT_CD');
				dsT_CM_PERSON2.Reset();

			} catch ( exception ) {
				
				fcWindowsXpSp2Notice(false);
				return;
				
			}
			
		}
	</script>

    <!------------------------------+
    | grid에서 row를 더블클릭했을때 |
    +------ ------------------------>
	<script for=grdT_CM_PERSON2 event=OnDblClick(Row,Colid)>
	
		//alert("Occur OnClick Event :" + "<ROW :" + Row +">"+ "<Colid :" + Colid + ">" );

		var url = "";
		var data = new String();

		if(Row < 1) {

			return;

		} else {
			
			dsT_CM_PERSON_DUTY.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.pir.i.piri010.cmd.PIRI010CMD&S_MODE=SHR_DUTY&ENO_NO="+gusrid;
			dsT_CM_PERSON_DUTY.reset();
			
	        var ENONO = dsT_CM_PERSON_DUTY.NameValue(1,'ENO_NO');			
	        var DUTYCD = dsT_CM_PERSON_DUTY.NameValue(1,'DUTY_CD');
	        var TEAMCD = dsT_CM_PERSON_DUTY.NameValue(1,'TEAM_CD');     
	        var DPTCD = dsT_CM_PERSON_DUTY.NameValue(1,'DPT_CD');


	        	//20 현장소장이면
	            if (DUTYCD == "20") {
   	
					            if (TEAMCD != dsT_CM_PERSON2.NameValue(Row,'TEAM_CD')) {	
					            	
					            	alert("현장소장님은 해당현장 인원만 조회가능하십니다.");
					            	
					            	return;
					            	
				            	}else{
				            		
					    			data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
					    			data.mode       = "read";
				
					    			url = "../../../Ehr/hr/pir/pirc010.jsp";
					    			
					    			window.showModalDialog(url, data, "dialogWidth:950px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	            	
				            	}
		            
	             }else{
	            	 
									// 2016.09.22 부서장 ->팀장제로 변경됐네 헷갈림 
									// 41 팀장이면
					 	            if (DUTYCD == "41") {	            

							            if (DPTCD != dsT_CM_PERSON2.NameValue(Row,'DPT_CD')) {	
							            	
							            	// 한상욱 부장님은 공공영업팀 + 토목사업팀 조회 가능 2020.04.14 이동훈
							            	if (ENONO == '2030002') {
							            		
							            		if (dsT_CM_PERSON2.NameValue(Row,'DPT_CD') == 'II25'){
								            		
													data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
													data.mode       = "read";
													url = "../../../Ehr/hr/pir/pirc010.jsp";
													window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	
								            		
							            		
													
													
							            		}else{

								            		alert("팀장님은 해당팀 인원만 조회가능하십니다.");
								            		return;
							            	
							            		}


							            	}
							            	
						            	}else{
						            		
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");		            		
							            	
							            	
							            	}	 	            	
					 	            	

								   // 이근재상무님, 고성철상무님은 건설사업본부 조회 가능 	            	
					 	           }else if (ENONO == '2040062') {				            

									    if (dsT_CM_PERSON2.NameValue(Row,'HEAD_CD') == 'II00'){
									            			
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	

						            	}else{
						            		
										    if (dsT_CM_PERSON2.NameValue(Row,'ENO_NO') == '2040067' || dsT_CM_PERSON2.NameValue(Row,'ENO_NO') == '2080006'){
						            			
												data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
												data.mode       = "read";
												url = "../../../Ehr/hr/pir/pirc010.jsp";
												window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	

										    }else{
										    	
										    	return;
										    	
										    }
						            		
											return;
						            	}	 										    
									    
  
								   // 이동훈 테스트	            	
					 	           }else if (ENONO == '6060002' || ENONO == '6180001') {				            
					 	        	   
					 	        	   
					            		if (dsT_CM_PERSON2.NameValue(Row,'DPT_CD') == 'II25'){
						            		
											data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
											data.mode       = "read";
											url = "../../../Ehr/hr/pir/pirc010.jsp";
											window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");	
						            		
					            		}
									    
					 	           }else{
					 	        	   
				
									data.eno_no = dsT_CM_PERSON2.NameValue(Row,'ENO_NO');
									data.mode       = "read";
				
									url = "../../../Ehr/hr/pir/pirc010.jsp";
									
									window.showModalDialog(url, data, "dialogWidth:1000px; dialogHeight:800px; help:No; resizable:No; status:No; scroll:Yes; center:Yes;");
							
					 	           }
	 	            
	             }

		}
	</script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="/common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="35" class="paddingTop5" align="right">
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSearch','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="imgSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgExit','','../../images/button/btn_ExitOver.gif',1)">  <img src="../../images/button/btn_ExitOn.gif"   name="imgExit" width="60" height="20" border="0" align="absmiddle" onClick="fnc_Exit()"></a>
        </td>
    </tr>
</table>
<!-- 버튼 테이블 끝 -->

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td colspan="2">
			<!-- power Search테이블 시작 -->
			<table width="1000" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="center" class="blueTable">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<colgroup>
											<col width="100"></col>

											<col width="*"></col>
										</colgroup>
										<tr>
											<td align="center" class="searchState">재직/퇴직구분&nbsp;</td>
											<td class="padding2423"><comment id="__NSID__">
												<object id=rdoEND_YN_SHR classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0
															style="height:20; width:180">
													<param name=AutoMargin	value="true">
													<param name=Cols		value="2">
													<param name=Format		value="1^재직자 기준,2^퇴직자 포함">
												</object>
												</comment><script> __ShowEmbedObject(__NSID__); </script>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- power Search테이블 끝 -->
		</td>
	</tr>
    <tr>
        <td>
            <!-- 조회 상태 테이블 시작 -->
            <table width="200" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="paddingTop8">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!-- 조회 상태 테이블 끝 -->
        </td>
    </tr>
	<tr>
		<td>
			<!-- 왼쪽 화면 시작-->
			<table width="300" border="0" cellspacing="0" cellpadding="0">
				<tr align="center"  valign="top">
					<td  valign="top">

						<!-- 내용 조회 그리드 테이블 시작-->
                        <table width="300" border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:300px;height:540px;">
                                        <param name="DataID"                        value="dsT_CM_PERSON">
                                        <param name="EdiTABLE"              value="false">
                                        <param name="DragDropEnable"        value="true">
                                        <param name="SortView"                  value="Left">
                                        <param name="VIEWSUMMARY"       value=0>
                                        <param name="Format"                        value="
                                            <C> id='CURROW'  	width=35   name='NO'   align=center        value={CurRow}  </C>
                                            <C> id='DPT_NM'  	width=200  name='소속'   align=left </C>
                                            <C> id='ENO_CNT' 	width=45   name='인원'   align=right </C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
						<!-- 내용 조회 그리드 데이블 끝-->
					</td>
				</tr>
			</table>
			<!-- 왼쪽 화면 끝-->
		</td>
		<td>
			<!-- 오른쪽 화면 시작-->
			<table width="700" border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<!-- 내용 조회 그리드 테이블 시작-->
                        <table width="600" border="0" cellspacing="0" cellpadding="0">
                            <tr align="center">
                                <td>
                                    <comment id="__NSID__">
                                    <object id="grdT_CM_PERSON2" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:700px;height:540px;">
                                        <param name="DataID"                        value="dsT_CM_PERSON2">
                                        <param name="EdiTABLE"              value="false">
                                        <param name="DragDropEnable"        value="true">
                                        <param name="SortView"                  value="Left">
                                        <param name="VIEWSUMMARY"       value=0>
                                        <param name="Format"                        value="
                                            <C> id='CURROW' width=45    name='NO'   align=center        value={CurRow}  </C>
                                            <C> id='ENO_NM'  width=80   name='성명'   align=center edit='none'</C>
                                            <C> id='ENO_NO'  width=70   name='사번'   align=center edit='none'</C>                                        
                                            <C> id='TEAM_NM' width=100   name='파트/현장'    align=left edit='none'</C>
                                            <C> id='DUTY_NM' width=80   name='직책'   align=center edit='none'</C>
                                            <C> id='JOB_NM'  width=100   name='직위'   align=center edit='none'</C>
                                            <C> id='HOB_NM'  width=60   name='년차'   align=center edit='none'</C>
                                            <C> id='HIR_YMD' width=70   name='입사일' align=center edit='none'</C>
                                            <C> id='RET_YMD' width=70   name='퇴직일' align=center     edit='none'</C>
                                        ">
                                    </object>
                                    </comment><script> __ShowEmbedObject(__NSID__); </script>
                                </td>
                            </tr>
                        </table>
						<!-- 내용 조회 그리드 데이블 끝-->
					</td>
				</tr>
  			</table>


	              <tr>
                    <td  colspan="2">
                    <br>
                    &nbsp;&nbsp;※ 개인별 자료를 더블클릭하면 세부정보가 조회됩니다.<br>
                    </td>
                </tr>


    		<!-- 오른쪽 화면 끝-->
		</td>
	</tr>
</table>

</form>
<!-- form 끝 -->


</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 


