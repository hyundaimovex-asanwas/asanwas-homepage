
<!--
*****************************************************
* @source      : idtc080.jsp
* @description : 주간업무확인 PAGE
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2020/11/30      이동훈        최초작성
*-------------+-----------+--------------------------+
*****************************************************
-->


<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>작성현황</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>


    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >



        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var pis_yy = document.getElementById('txtPIS_YY_SHR').value;


            dsT_WF_WORKFORM.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.idt.c.idtc080.cmd.IDTC080CMD"
													                + "&S_MODE=SHR"						                                
													                + "&PIS_YY="+pis_yy;
			
			dsT_WF_WORKFORM.Reset();    		
    		
    		
        }

        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {

            //이곳에 해당 코딩을 입력 하세요

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

			//이곳에 해당 코딩을 입력 하세요

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

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 08. 추가 함수  *
         ******************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /******************
         * 09. 제거 함수  *
         ******************/
        function fnc_Remove() {

			//이곳에 해당 코딩을 입력 하세요

        }

        /********************
         * 10. 초기화 함수  *
         ********************/
        function fnc_Clear() {


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


        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {

            return true;

        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

            //날짜값들 바인딩
            var svc_ymd     = gcurdate;

            svc_ymd     = addDate("M", gcurdate, 0);
            
            document.getElementById("txtPIS_YY_SHR").value = svc_ymd.substr(0,4); // 해당년

			//값이 없어서 하이픈만 나오는거 방지
			var PIS_YY_SHR = (document.getElementById("txtPIS_YY_SHR").value).replace("-", "").replace("-", "");

			if(PIS_YY_SHR.trim() == ""){
				
				document.getElementById("txtPIS_YY_SHR").value = "";
				
			}

            //Grid Style 적용
			cfStyleGrid_New(form1.grdT_WF_WORKFORM,0,"false","false");

			fnc_SearchList();


	    }




		/********************
         * 15. 단축키 처리  *
         *******************/
		function fnc_HotKey() {

			fnc_HotKey_Process(btnList, event.keyCode);

		}

    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------+
    | 1. 조회용 DataSet								 |
    | 2. 이름은 ds_ + 주요 테이블명(dsT_WF_WORKFORM)|
    | 3. 사용되는 Table List(T_WF_WORKFORM)		 |
    +------------------------------------------------>
    <Object ID="dsT_WF_WORKFORM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>


    <!-----------------------------------------------------+
    | 1. 조회 및 저장용 Data Transacton					   |
    | 2. 이름은 tr_ + 주요 테이블명(T_WF_WORKFORM)		   |
    | 3. 사용되는 Table List(T_WF_WORKFORM)			   |
    +------------------------------------------------------>
	<Object ID="trT_WF_WORKFORM" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
		<Param Name=KeyName Value="toinb_dataid4">
		<Param Name=KeyValue Value="sample_tr01(O:dsT_DI_YEARLY=dsT_DI_YEARLY)">
	</Object>





    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->



    <!------------------------------+
    | 그리드의 ROW를 더블클릭 할때  |
    +------------------------------->
	<script language=JavaScript for=grdT_WF_WORKFORM event="OnDblClick(row,colid)">

	    curRowPosition = dsT_WF_WORKFORM.RowPosition;
	
	    
	    
		if(colid == "ENO_NM") {
			
			//성명 더블클릭시 전체 작성 현황 표시
	        var url = "../../hr/idt/idtc082.jsp?ENO_NO="+dsT_WF_WORKFORM.NameString(row, "ENO_NO");
            
	        //alert(url);
	        
	   		cfWinOpen(url,"주간업무일지",1100,800);
			
		} else {

			var dummy = colid.substr(2,3); // 해당년
			var WEEK_NO; 
			
			
			if(dummy == "11"){
				WEEK_NO = 1;
			}else if(dummy == "12"){
				WEEK_NO = 2;
			}else if(dummy == "13"){
				WEEK_NO = 3;
			}else if(dummy == "14"){
				WEEK_NO = 4;					
			}else if(dummy == "21"){
				WEEK_NO = 5;
			}else if(dummy == "22"){
				WEEK_NO = 6;
			}else if(dummy == "23"){
				WEEK_NO = 7;
			}else if(dummy == "24"){
				WEEK_NO = 8;		
			}else if(dummy == "31"){
				WEEK_NO = 9;
			}else if(dummy == "32"){
				WEEK_NO = 10;
			}else if(dummy == "33"){
				WEEK_NO = 11;					
			}else if(dummy == "34"){
				WEEK_NO = 12;
			}else if(dummy == "35"){
				WEEK_NO = 13;				
			}else if(dummy == "42"){
				WEEK_NO = 14;
			}else if(dummy == "43"){
				WEEK_NO = 15;
			}else if(dummy == "44"){
				WEEK_NO = 16;					
			}else if(dummy == "45"){
				WEEK_NO = 17;	
			}else if(dummy == "52"){
				WEEK_NO = 18;
			}else if(dummy == "53"){
				WEEK_NO = 19;
			}else if(dummy == "54"){
				WEEK_NO = 20;					
			}else if(dummy == "55"){
				WEEK_NO = 21;					
				
			}
			
			
	        var url = "../../hr/idt/idtc081.jsp?ENO_NO="+dsT_WF_WORKFORM.NameString(row, "ENO_NO")+"&WEEK_NO="+WEEK_NO;
	               
	        //alert(url);
	        
	   		cfWinOpen(url,"주간업무일지",1100,800);
	  
		}
		
	</script>



    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_WF_WORKFORM Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

			fnc_Message(document.getElementById("resultMessage"), "MSG_02");

        } else {

			fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_WF_WORKFORM Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>


	<!-----------------------------------------------------+
    | Transaction Successful 처리     					   |
    +------------------------------------------------------>
	<script for=trT_WF_WORKFORM event="OnSuccess()">
        fnc_Message(document.getElementById("resultMessage"), "MSG_01");
    </script>

	<!-----------------------------------------------------+
    | Transaction Failure 처리    	   					   |
    +------------------------------------------------------>
	<script for=trT_WF_WORKFORM event="OnFail()">
        cfErrorMsg(this);
    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>

<!-- form 시작 -->
<form name="form1">


<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<colgroup>
						<col width="70"></col>
						<col width=""></col>
					</colgroup>
	                        <tr>
					<td align="center" class="searchState">기준년</td>
					<td>
						<input id="txtPIS_YY_SHR" size="4" maxlength="4" onblur="cfCheckDate(this);" onkeypress="cfDateHyphen(this);cfCheckNumber();if(event.keyCode==13)fnc_SearchList();" style="ime-mode:disabled" onchange = "fnc_SearchList()">
					 </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->


<!-- 내용 조회 그리드 데이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr align="center">
					<td>
						<comment id="__NSID__">
						<object	id="grdT_WF_WORKFORM" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:595px;">
							<param name="DataID"					value="dsT_WF_WORKFORM">
                            <param name="ColSelect"  				value="true">
							<PARAM NAME="BorderStyle"				VALUE="0">
							<PARAM NAME="Indwidth"					VALUE="0">
							<PARAM NAME="Fillarea"					VALUE="true">
							<PARAM NAME="Editable"					VALUE="false">
							<PARAM NAME="Colsizing"					VALUE="true">
							<PARAM NAME="TitleHeight"				VALUE=15>
							<param name="GTitleHeight"              value=20>							
							<param name="sortview"					value=left>
                            <param name="Format"					value="
								<FC>ID={CurRow}		Name='순'	Width=20   		align=center  	sort=false  editable=false</FC>
								<FC> ID='DPT_NM'	width=80	Name='소속'		align=left		edit=none  sort=true suppress=1</FC>
								<FC> ID='ENO_NO'	width=60	Name='사번'		align=center	edit=none  sort=true show=false</FC>
								<FC> ID='ENO_NM'	width=60	Name='성명'		align=center	edit=none  sort=true</FC>

                               <G> name='1월' 		BgColor='#dae0ee'
                                <C> id='AT11'		width=25	name='1주'		align=center    BgColor={Decode(AT11,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT12'	    width=25	name='2주'		align=center    BgColor={Decode(AT12,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT13'	    width=25	name='3주'	    align=center    BgColor={Decode(AT13,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT14'	    width=25	name='4주'		align=center    BgColor={Decode(AT14,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT15'	    width=25	name='5주'		align=center    BgColor={Decode(AT11,'X','#FFC6C6','#FFFFFF')} show=false</C>
                               </G>
                               
                               <G> name='2월' 		BgColor='#dae0ee'
                                <C> id='AT21'	    width=25	name='1주'	    align=center    BgColor={Decode(AT21,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT22'     	width=25	name='2주'		align=center    BgColor={Decode(AT22,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT23'    	width=25	name='3주'		align=center    BgColor={Decode(AT23,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT24'     	width=25	name='4주'		align=center    BgColor={Decode(AT24,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='3월' 		BgColor='#dae0ee'
                                <C> id='AT31'     	width=25	name='1주'		align=center    BgColor={Decode(AT31,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT32'    	width=25	name='2주'		align=center    BgColor={Decode(AT32,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT33'    	width=25	name='3주'		align=center    BgColor={Decode(AT33,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT34'    	width=25	name='4주'		align=center    BgColor={Decode(AT34,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT35'    	width=25	name='5주'		align=center    BgColor={Decode(AT35,'X','#FFC6C6','#FFFFFF')} </C>                                
                               </G>
                               
                               <G> name='4월' 		BgColor='#dae0ee'
                                <C> id='AT42'    	width=25	name='2주'		align=center    BgColor={Decode(AT42,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT43'    	width=25	name='3주'		align=center    BgColor={Decode(AT43,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT44'   	width=25	name='4주'		align=center    BgColor={Decode(AT44,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT45'    	width=25	name='5주'		align=center    BgColor={Decode(AT45,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='5월' 		BgColor='#dae0ee'
                                <C> id='AT52'    	width=25	name='2주'		align=center    BgColor={Decode(AT52,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT53'    	width=25	name='3주'		align=center    BgColor={Decode(AT53,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT54'    	width=25	name='4주'		align=center    BgColor={Decode(AT54,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT55'    	width=25	name='5주'		align=center    BgColor={Decode(AT55,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='6월' 		BgColor='#dae0ee'
                                <C> id='AT61'    	width=25	name='1주'		align=center    BgColor={Decode(AT61,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT62'    	width=25	name='2주'		align=center    BgColor={Decode(AT62,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT63'    	width=25	name='3주'		align=center    BgColor={Decode(AT63,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT64'    	width=25	name='4주'		align=center    BgColor={Decode(AT64,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT65'    	width=25	name='5주'		align=center    BgColor={Decode(AT65,'X','#FFC6C6','#FFFFFF')} </C>                                
                               </G>
                               
                               <G> name='7월' 		BgColor='#dae0ee'                                
                                <C> id='AT71'    	width=25	name='1주'		align=center    BgColor={Decode(AT71,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT72'    	width=25	name='2주'		align=center    BgColor={Decode(AT72,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT73'    	width=25	name='3주'		align=center    BgColor={Decode(AT73,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT74'    	width=25	name='4주'		align=center    BgColor={Decode(AT74,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='8월' 		BgColor='#dae0ee'                                
                                <C> id='AT81'    	width=25	name='1주'		align=center    BgColor={Decode(AT81,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT82'    	width=25	name='2주'		align=center    BgColor={Decode(AT82,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT83'    	width=25	name='3주'		align=center    BgColor={Decode(AT83,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT84'    	width=25	name='3주'		align=center    BgColor={Decode(AT84,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='9월' 		BgColor='#dae0ee'
                                <C> id='AT91'    	width=25	name='1주'		align=center    BgColor={Decode(AT91,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT92'    	width=25	name='2주'		align=center    BgColor={Decode(AT92,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT93'    	width=25	name='3주'		align=center    BgColor={Decode(AT93,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT94'    	width=25	name='4주'		align=center    BgColor={Decode(AT94,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='10월' 		BgColor='#dae0ee'
                                <C> id='AT101'    	width=25	name='1주'		align=center    BgColor={Decode(AT101,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT102'    	width=25	name='2주'		align=center    BgColor={Decode(AT102,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT103'    	width=25	name='3주'		align=center    BgColor={Decode(AT103,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT104'    	width=25	name='4주'		align=center    BgColor={Decode(AT104,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='11월' 		BgColor='#dae0ee'
                                <C> id='AT111'    	width=25	name='1주'		align=center    BgColor={Decode(AT111,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT112'    	width=25	name='2주'		align=center    BgColor={Decode(AT112,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT113'    	width=25	name='3주'		align=center    BgColor={Decode(AT113,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT114'    	width=25	name='4주'		align=center    BgColor={Decode(AT114,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                               
                               <G> name='12월' 		BgColor='#dae0ee'                                
                                <C> id='AT121'    	width=25	name='1주'		align=center    BgColor={Decode(AT121,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT122'    	width=25	name='2주'		align=center    BgColor={Decode(AT122,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT123'    	width=25	name='3주'		align=center    BgColor={Decode(AT123,'X','#FFC6C6','#FFFFFF')} </C>
                                <C> id='AT124'    	width=25	name='4주'		align=center    BgColor={Decode(AT124,'X','#FFC6C6','#FFFFFF')} </C>
                               </G>
                              
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	
	
	
	<tr>
		<td align="left" class="blueBold">
			<br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;■ 성명을 더블클릭하시면 전체 작성 현황을 조회하실 수 있습니다.</font>
			<br>
			<font color="blue" size="2" bold="5" face = "Verdana"">&nbsp;&nbsp;■ Grid를 더블클릭하시면 해당 직원의 해당주 작성 현황을 조회하실 수 있습니다.</font> 	
			<br>			
		</td>
	 </td>
	</tr>	
	
	
</table>
<!-- 내용 조회 그리드 데이블 끝-->





</form>
<!-- form 끝 -->

</body>
</html>


<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 





