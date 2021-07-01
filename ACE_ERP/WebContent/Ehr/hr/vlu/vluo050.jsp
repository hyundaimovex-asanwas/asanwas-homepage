<!--
***********************************************************************
* @source      : vluo050.jsp
* @description : 업무 목표승인 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/02/13      이동훈        최초작성.
***********************************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>업무 목표승인</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/style_new.css" rel="stylesheet" type="text/css">	
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var year    = "2021";

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {


        	var EVL_YYYY = document.getElementById("txtEVL_YYYY").value;
        	var TEAM_CD = document.getElementById("txtTEAM_CD").value;
            var ENO_NO = document.getElementById("txtENO_NO").value;
        	
        	
        	dsT_EVL_APPROVAL.DataId = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo050.cmd.VLUO050CMD&S_MODE=SHR&EVL_YYYY="+EVL_YYYY+"&TEAM_CD="+TEAM_CD+"&ENO_NO="+ENO_NO+"&STATUS="+document.getElementById("cmbSTATUS").value+"&SEQ="+document.getElementById("cmbSEQ").value;
			dsT_EVL_APPROVAL.Reset();            

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

            if (dsT_EVL_APPROVAL.CountRow < 1) {
                alert("엑셀로 변환할 자료가 없습니다!");
                return;
            }

            form1.grdT_EVL_APPROVAL.GridToExcel("평가체계", '', 225);
        	
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

            //이곳에 해당 코딩을 입력 하세요

        }

        /*************************
         * 13. 저장 유효성 체크  *
         *************************/
        function fnc_SaveItemCheck() {


        }

        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  	*
         *******************************************/
        function fnc_OnLoadProcess() {

        	
     	
        	
            //소속 조회
            dsT_EVL_TEAM.dataid = "../../../servlet/GauceChannelSVL?cmd=Ehr.vlu.o.vluo050.cmd.VLUO050CMD&S_MODE=SHR_TEAM&ENO_NO="+gusrid;
            dsT_EVL_TEAM.reset();

            document.getElementById("txtEVL_YYYY").value = year;   
            document.getElementById('txtTEAM_CD').value = dsT_EVL_TEAM.NameValue(1,"TEAM_CD");
            document.getElementById('txtTEAM_NM').value = dsT_EVL_TEAM.NameValue(1,"TEAM_NM");              
            document.getElementById("txtENO_NO").value = gusrid;
            document.getElementById("txtENO_NM").value = gusrnm;

         
    	//관리자의 경우 사번 검색 활성화
    	if(gusrid != "6060002" && gusrid != "6180001" && gusrid != "1990071" && gusrid != "2020008" && gusrid != "2070020"){ 

			document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
	  		
			document.getElementById("txtTEAM_CD").className = "input_ReadOnly";
	  		document.getElementById("txtTEAM_CD").readOnly = true;	  		
			document.getElementById("txtTEAM_NM").className = "input_ReadOnly";
	  		document.getElementById("txtTEAM_NM").readOnly = true;
	  		document.getElementById("ImgTeam").style.display = "none";
	  		
			document.getElementById("txtENO_NO").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NO").readOnly = true;	  		
			document.getElementById("txtENO_NM").className = "input_ReadOnly";
	  		document.getElementById("txtENO_NM").readOnly = true;
	  		document.getElementById("ImgEnoNo").style.display = "none";

		}else{

            document.getElementById("txtEVL_YYYY").className = "input_ReadOnly";
	  		document.getElementById("txtEVL_YYYY").readOnly = true;
			document.getElementById("txtENO_NO").className = "";
	  		document.getElementById("txtENO_NO").readOnly = false;	  			  		
	  		document.getElementById("txtENO_NM").className = "";
	  		document.getElementById("txtENO_NM").readOnly = false;

    	}

			cfStyleGrid_New(form1.grdT_EVL_APPROVAL, 0, "true", "true");    	
    	
    		fnc_SearchList();

        }


        function fnc_GetNm() {
            fnc_GetEnoNm('txtENO_NO', 'txtENO_NM','0','0');
            fnc_SearchList();

	    }
	
	    function fnc_Getcd() {
	            fnc_GetEnoNo('txtENO_NM','txtENO_NO');
	            fnc_SearchList();
	    }                
        
    </script>

    </head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!-----------------------------------------------------+
    | 그리드의 ROW를 더블클릭 시 처리  	   				   |
    +------------------------------------------------------>
	<script language=JavaScript for=grdT_EVL_APPROVAL event="OnDblClick(row,colid)">

			curRowPosition = dsT_EVL_APPROVAL.RowPosition;

			if(dsT_EVL_APPROVAL.CountRow < 1) {
				alert("결재할 자료가 없습니다.");
				return;
			}

			var url = "../../../Ehr/hr/vlu/vluo101.jsp?ENO_NO=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NO") + "&ENO_NM=" + dsT_EVL_APPROVAL.NameValue(row,"ENO_NM") + "&GOAL_SEQ=" + dsT_EVL_APPROVAL.NameValue(row,"GOAL_SEQ");

			window.showModalDialog(url, "Modal", "dialogWidth:1100px; dialogHeight:750px; help:No; resizable:YES; status:No; scroll:Yes; center:Yes;");
            
			fnc_SearchList();

	</script>

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     |
    | 2. 이름은 ds_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID="dsT_EVL_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <Object ID="dsT_EVL_TEAM" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>

    <!----------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton        |
    | 2. 이름은 tr_ + 주요 테이블명(T_EVL_APPROVAL) |
    | 3. 사용되는 Table List(T_EVL_APPROVAL)        |
    +----------------------------------------------->
    <Object ID ="trT_EVL_APPROVAL" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
            <Param Name=KeyValue    Value="tr01(I:SAV=dsT_EVL_APPROVAL)">
    </Object>

    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_EVL_APPROVAL Event="OnLoadCompleted(iCount)">

    if (iCount == 0) {
		fnc_Message(document.getElementById("resultMessage"), "MSG_02");
    } else {
        fnc_Message(document.getElementById("resultMessage"), "MSG_03", iCount);
    }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
     <Script For=dsT_EVL_GOALLIST Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

        // 에러 메세지 처리 후 다음 처리 할 내용 코딩

    </Script>






<!--
***********************************************************************
* BODY START
***********************************************************************
-->

<jsp:include page="/Common/sys/body_s21.jsp"  flush="true"/>


<!-- form 시작 -->
<form name="form1">



<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="35" class="paddingTop5" align="right">
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image6','','../../images/button/btn_ExcelOver.gif',1)"> <img src="../../images/button/btn_ExcelOn.gif"  name="Image6" width="60" height="20" border="0" align="absmiddle" onClick="fnc_ToExcel()"></a>
            &nbsp;&nbsp;
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image1','','../../images/button/btn_SearchOver.gif',1)"><img src="../../images/button/btn_SearchOn.gif" name="Image1" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()"></a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="center" class="blueTable">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <colgroup>
                                <col width="80"></col>
                                <col width="100"></col>
                                <col width="50"></col>
                                <col width="200"></col>                                
                                <col width="50"></col>
                                <col width="150"></col>
                                <col width="50"></col>
                                <col width="100"></col>                                                                  
                                <col width="*"></col>
                            </colgroup>
                            <tr>
                                <td class="searchState" align="right">작성년월&nbsp;</td>
                                <td class="padding2423" align="left" id="key1"  style="display:">
                                    <input type="text" id="txtEVL_YYYY" name="txtEVL_YYYY" style="ime-mode:disabled" size="7" maxlength="7" readOnly class="input_ReadOnly"  >
                               </td>
								<td align="right" class="searchState">팀&nbsp;</td>
								<td class="padding2423">								
					                <input id="txtTEAM_CD" name="txtTEAM_CD" size="9"  maxlength= "8"   style="ime-mode:disabled" onChange="fnc_GetCommNm('A4','txtTEAM_CD','txtTEAM_NM');">
					                <input id="txtTEAM_NMR" name="txtTEAM_NM" size="12" maxlength= "14"  >
					                <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)">
					                <img src="../../images/button/btn_HelpOn.gif" id="ImgTeam" name="ImgTeam" width="21" height="20" border="0" align="absmiddle" onclick="fnc_commnmPopup('txtTEAM_CD','txtTEAM_NM','소속','DEPT')" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgTeam','','../../images/button/btn_HelpOver.gif',1)" style="cursor:hand;">
					            </td>	                               
                                <td align="right" class="searchState">성명</td>
                                <td class="padding2423">
                                    <input id=txtENO_NO name=txtENO_NO size="7"  maxlength="7" onKeyPress="JavaScript: if (event.keyCode == 13){fnc_GetEnoNm('txtENO_NO', 'txtENO_NM'); fnc_SearchList();}"  onChange="fnc_GetEnoNm('txtENO_NO', 'txtENO_NM');">
                                    <input id=txtENO_NM name=txtENO_NM size="8" onKeyPress="JavaScript: if (event.keyCode == 13) {fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');fnc_SearchList();}" onchange="fnc_GetEnoNo('txtENO_NM', 'txtENO_NO');">
                                    <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgEnoNo','','../../images/button/btn_HelpOver.gif',1)">
                                    <img src="../../images/button/btn_HelpOn.gif" id="ImgEnoNo" name="ImgEnoNo" width="21" height="20" border="0" align="absmiddle" onclick="fnc_emplPopup('txtENO_NO','txtENO_NM')"></a>
                                </td>
								<td align="center" class="searchState">구분</td>
								<td>
									<select id="cmbSTATUS" style="WIDTH:100" onChange="fnc_SearchList();">
											<option value="" >전체</option>
											<option value="S">저장</option>		
											<option value="R">상신</option>												
											<option value="Y">완료</option>																	
									</select>
								</td>      
								<td align="center" class="searchState">차수</td>
								<td>
									<select id="cmbSEQ" style="WIDTH:100" onChange="fnc_SearchList();">
											<option value="" >전체</option>
											<option value="1">1차</option>		
											<option value="2">2차</option>																											
									</select>
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



<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop8">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" width="600" class="searchState"><span id="resultMessage">&nbsp;</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->



<!-- 내용 조회 그리드 테이블 시작-->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop3">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr align="center">
                        <td>
                            <comment id="__NSID__">
                            <object    id="grdT_EVL_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
                                <param name="DataID"                 	value="dsT_EVL_APPROVAL">
                                <param name="EdiTABLE"               	value="true">
                                <param name="DragDropEnable"         	value="true">
                                <param name="AutoReSizing"           	value="true">
                                <param name="ColSizing"  				value="true">
								<param name="SortView" 					value="right">                                   
                                <param name="RowHeight"   				value="10">
								<param name="TitleHeight" 				value="20">
								<param name="VIEWSUMMARY"          		value=1>							
                                <param name="Format"                 	value="

			                        <G> name='승인자' 		BgColor='#dae0ee'									                             
			                        <C> id=HTEAM_NM         width=140   	name='소속'        align=center Edit=None </C>
			                        <C> id=HJOB_NM          width=90   		name='직위'		   align=center Edit=None </C>
			                        <C> id=HENO_NO          width=70   		name='사번'        align=center Edit=None </C>
			                        <C> id=HENO_NM          width=100   	name='성명'        align=center Edit=None </C>
			                        </G>			                        
			                        <G> name='대상자' 		BgColor='#dae0ee'
			                        <C> id=TEAM_NM          width=140   	name='소속'        align=center Edit=None </C>
			                        <C> id=JOB_NM          	width=90   		name='직위'		   align=center Edit=None </C>			                        
			                        <C> id=ENO_NO          	width=70   		name='사번'        align=center Edit=None </C>
			                        <C> id=ENO_NM          	width=100   	name='성명'        align=center Edit=None </C>
			                        </G>
			                        <C> id=GOAL_SEQ    		width=70   		name='차수'  	   align=center Edit=None </C>			                        
			                        <C> id=STATUS    		width=100   	name='목표승인여부'  align=center Edit=None </C>
                                ">
                            </object>
                            </comment><script> __ShowEmbedObject(__NSID__); </script>
                        </td>
                    </tr>
				</table>
		</td>
		</tr>
</table>



<!-- 내용 조회 그리드 데이블 끝-->
</form>
<!-- form 끝 -->


</body>
</html>