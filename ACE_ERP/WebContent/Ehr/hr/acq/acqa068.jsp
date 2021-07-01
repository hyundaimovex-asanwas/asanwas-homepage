<!--*************************************************************************
* @source      : acqa068.jsp												*
* @description : Action Plan > 조직 및 인력	> (북측인력) 임금수준 및 고용형태*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/15            이동훈       번갯불에 콩을 구워먹어도 유분수지		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>(북측인력) 임금수준 및 고용형태</title>
<jsp:include page="/Ehr/common/include/head.jsp"/>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
	<link href="../../common/css/style.css" rel="stylesheet" type="text/css">
	<link href="../../common/css/general.css" rel="stylesheet" type="text/css">

	<script language=javascript src="../../common/common.js"></script>
	<script language=javascript src="../../common/result.js"></script>
	<script language=javascript src="../../common/input.js"></script>
	<script language="javascript" src="../../common/calendar/calendar.js"></script>



	<!-- 첨부 파일을 위해 -->
    <jsp:include page="../../../Ehr/common/fileupload.jsp" flush="true" />
    <!-- 첨부 파일을 위해 -->



    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

        var obj = new String();
        
		obj.app_cmt = "";



        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            var DOC_GB2 = document.getElementById("txtDOC_GB2_SHR").value;
            var DOC_GB3 = document.getElementById("txtDOC_GB3_SHR").value;

            trT_ACT_PLANLIST.KeyValue = "tr(O:dsT_ACT_PLANLIST=dsT_ACT_PLANLIST)";
            trT_ACT_PLANLIST.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa060.cmd.ACQA060CMD&S_MODE=SHR&DOC_GB2="+DOC_GB2+"&DOC_GB3="+DOC_GB3;
            trT_ACT_PLANLIST.post();               

        }


        /***********************************
         * 02. 조회 함수_Item 형태의 조회  *
         ***********************************/
        function fnc_SearchItem() {


        }


        /***********************************
         * 			03. 저장 함수  			*
         ***********************************/
        function fnc_Save() {


        }


        
        /***********************************
         * 			04. 삭제 함수  			*
         ***********************************/
        function fnc_Delete() {

			//이곳에 해당 코딩을 입력 하세요

        }

        
        
        /***********************************
         * 			05. 인쇄 함수  			*
         ***********************************/
        function fnc_Print() {


        }

        
        
        /***********************************
         * 			06. 엑셀 저장 함수  	*
         ***********************************/
        function fnc_ToExcel() {

            //이곳에 해당 코딩을 입력 하세요

        }


        /***********************************
         * 			07. 신규 함수  			*
         ***********************************/
        function fnc_AddNew() {



        }

        
        /***********************************
         * 			08. 추가 함수 		 	*
         ***********************************/
        function fnc_Append() {

			//이곳에 해당 코딩을 입력 하세요
			
        }
		
		

        /***********************************
         * 			09. 제거 함수  			*
         ***********************************/
        function fnc_Remove() {


			
        }

        
        
        /***********************************
         * 			10. 초기화 함수  		*
         ***********************************/
        function fnc_Clear() {



        }

        
        
        /***********************************
         * 			11. 화면 종료(닫기) 	*
         ***********************************/
        function fnc_Exit() {


        }
        
        
        

        /***********************************
         * 		12. 검색 조건 유효성 검사  *
         ***********************************/
        function fnc_SearchItemCheck() {

			//이곳에 해당 코딩을 입력 하세요

        }

        
        
        
        
        /***********************************
         * 		13. 저장 유효성 체크  		*
         ***********************************/
        function fnc_SaveItemCheck() {


        }

        
        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_DI_APPROVAL,0,"false","false");      // Grid Style 적용
			cfStyleGrid_New(form1.grdT_ACT_PLANLIST,0,"false","true");      // Grid Style 적용		
			
			form1.grdT_DI_APPROVAL.TitleHeight = 18;
			form1.grdT_DI_APPROVAL.RowHeight = 18;			
			
			fnc_SearchList();
			
            fnc_InputDisabled();//입력란 disabled			
			

        }


		
        /***********************************
         *    	입력란 Disabled처리  		*
         ***********************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDOC_GB1").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB1").readOnly = true;
            document.getElementById("txtDOC_GB2").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB2").readOnly = true;
            document.getElementById("txtDOC_GB3").className = "input_ReadOnly";
            document.getElementById("txtDOC_GB3").readOnly = true;
            document.getElementById("txtDOC_TITLE").className = "input_ReadOnly";
            document.getElementById("txtDOC_TITLE").readOnly = true;
            document.getElementById("txtDOC_REMARK").className = "input_ReadOnly";
            document.getElementById("txtDOC_REMARK").readOnly = true;

            document.getElementById("ImgDOC_GB1").style.display = "none";            
            document.getElementById("ImgDOC_GB2").style.display = "none";            
            document.getElementById("ImgDOC_GB3").style.display = "none";
            
            document.getElementById("cmbDOC_STATUS").disabled  = true;
        }

        
		
        /************************************************
         *        	문서 종류 팝업창 처리               *
         ************************************************/
        function fnc_DocNmPopup(gbn) {

            var obj = new String();

            if (gbn == 'GB2') {
            	
                obj.title = '문서';
                obj.gbn   = 'DOC2';
                obj.up_cd  = document.getElementById('txtDOC_GB1_SHR').value;         
                
                window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");

                if(obj.comm_cd != '' && obj.comm_nm != '') {
                	
                    document.getElementById('txtDOC_GB2_SHR').value  = obj.comm_cd;
                    document.getElementById('txtDOC_NM2_SHR').value  = obj.comm_nm;
                    document.getElementById('txtDOC_GB3_SHR').value = '';
                    document.getElementById('txtDOC_NM3_SHR').value = '';                     
                    
                    
                }
                	fnc_SearchList();
                	
            }else if (gbn == 'GB3') {
            	
                if (document.getElementById("txtDOC_GB2_SHR").value == "") {

	                    alert("상위코드를 먼저 입력하신 후 팝업창을 선택하여 주십시오.");
	                    return;

                }else {
                	
                    obj.title = '문서';
                    obj.gbn   = 'DOC3';
                    obj.up_cd  = document.getElementById('txtDOC_GB2_SHR').value;
                    
                    window.showModalDialog("../../common/popup/docnm.jsp", obj, "dialogWidth:500px; dialogHeight:440px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
                    
                    if(obj.comm_cd != '' && obj.comm_nm != '') {
                    	
                        document.getElementById('txtDOC_GB3_SHR').value  = obj.comm_cd;
                        document.getElementById('txtDOC_NM3_SHR').value  = obj.comm_nm;
         
                    }       
                    
                    fnc_SearchList();
                    
                }
                
            }
            
        }        

    </script>

    </head>




    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_PLANLIST" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    
    
    <Object ID="dsT_ACT_APPROVAL" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    

    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_ACT_PLANLIST)	    |
    | 3. 사용되는 Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_PLANLIST" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    
    <Object ID ="trT_ACT_APPROVAL_SHR" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>    
  
    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->

    <Script For=dsT_ACT_APPROVAL Event="OnLoadCompleted(iCount)">
    
    </Script>


    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>

    <Script For=dsT_ACT_APPROVAL Event="OnLoadError()">

        //Error Message 처리(Session Chekc, Biz Logic의 Error 처리)
        cfErrorMsg(this);

    </Script>
    

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>




    <!-----------------------------------------------------+
    | 			Transaction Successful 처리  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_PLANLIST event="OnSuccess()">

        trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
        trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa060.cmd.ACQA060CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
        trT_ACT_APPROVAL_SHR.post();      
        
    </script>    


    <!-----------------------------------------------------+
    | 			Transaction Failure 처리  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_PLANLIST event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


    <!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리 |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ACT_PLANLIST event=OnRowPosChanged(row)>  	
        	
        if(row > 0) {
        	
            //등록된 파일들 조회
            fnc_GetFileList(dsT_ACT_PLANLIST.NameValue(row, "FILE_KEY"));

            //결재선 새로 조회
            trT_ACT_APPROVAL_SHR.KeyValue = "tr(O:dsT_ACT_APPROVAL=dsT_ACT_APPROVAL)";
            trT_ACT_APPROVAL_SHR.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa060.cmd.ACQA060CMD&S_MODE=SHR_APP&REQ_NO="+document.getElementById("txtREQ_NO").value;
            trT_ACT_APPROVAL_SHR.post();                

        }

	</script>


	<!-----------------------------------------------------+
    | 		grdT_DI_APPROVAL OnClick 처리 - 사유 조회      |
    +------------------------------------------------------>
  <script language="javascript"  for=grdT_DI_APPROVAL event=OnClick(Row,Colid)>

	if(Colid == "REMARK1" && dsT_ACT_APPROVAL.NameValue(Row, "REMARK1") == "Click" ){
		
		obj =  dsT_ACT_APPROVAL.NameValue(Row, "REMARK");
		
		window.showModalDialog("./acqa015.jsp", obj, "dialogWidth:500px; dialogHeight:200px; help:No; resizable:No; status:No; scroll:No; center:Yes;");
		
	}

  </script>
  
	<!-- 파일 그리드 클릭시 다운로드 되게 -->
   <script language="javascript"  for=grdFILE event=OnDblClick(row,colid)>
   
       if(row > 0) {
       	
           var vFILE_NAME  = dsFILE.NameValue(row, "FILE_NAME");
           var vFILE_URL   = dsFILE.NameValue(row, "FILE_URL");
          
           // 첨부 파일이 존재하는 경우만 수행하게~
           if (vFILE_NAME != "" && vFILE_URL != "") {
			cfDownload(vFILE_NAME,vFILE_URL);
           }
       }
       
   </script>  
  
 
 
 
 
<!--
**************************************************************
* BODY START
**************************************************************
-->

<jsp:include page="/Common/sys/body_s22.jsp"  flush="true"/>

<!-- 켈린더 프레임-->
<div class="calendar" id="ifrmcal" style="DISPLAY:none">
	<iframe name="calendarfrm" marginwidth="0" marginheight="0" frameborder="0" src="../../common/calendar/ifrmcalendar.htm" width="100%" height="100%" scrolling="no" ></iframe>
</div>


<!-- form 시작 -->
<form name="form1">

<!-- 버튼 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>
		<td class="paddingTop5" align="right" >
			<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageSearch','','../../images/button/btn_SearchOver.gif',1)">
				<img src="../../images/button/btn_SearchOn.gif" name="ImageSearch" width="60" height="20" border="0" align="absmiddle" onClick="fnc_SearchList()">
			</a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- power Search테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" class="blueTable">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<colgroup>
				<col width="50"></col>
				<col width="100"></col>
				<col width="50"></col>
				<col width="100"></col>
				<col width="50"></col>
				<col width="100"></col>				
				<col width="*"></col>
			</colgroup>
			<tr>
			
                <td align="center" class="blueBold">대분류</td>
                <td class="padding2423">
                    <input id="txtDOC_GB1_SHR" style="width:10%" class="input_ReadOnly"  readonly value="D"> 
                    <input id="txtDOC_NM1_SHR" style="width:50%" class="input_ReadOnly"  readonly value="조직 및 인력">
                </td>			

                <td align="center" class="blueBold">중분류</td>
                <td class="padding2423">
                    <input id="txtDOC_GB2_SHR" style="width:10%" class="input_ReadOnly"  readonly value="DI"> 
                    <input id="txtDOC_NM2_SHR" style="width:50%" class="input_ReadOnly"  readonly value="(북측인력) 임금수준 및 고용형태">                
                </td>
                
                <td align="center" class="blueBold">세부분류</td>
                <td class="padding2423">
                    <input id="txtDOC_GB3_SHR" style="width:20%" class="input_ReadOnly"  readonly value="DI01"> 
                    <input id="txtDOC_NM3_SHR" style="width:50%" class="input_ReadOnly"  readonly value="(북측인력) 임금수준 및 고용형태">                
                </td>		
			</tr>
		</table>
		</td>
	</tr>
</table>
<!-- power Search테이블 끝 -->


<!-- 문서 현황 정보 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_PLANLIST" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:305px;">
				<param name="DataID"				value="dsT_ACT_PLANLIST">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=45   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=80	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_STATUS'			width=50	name='상황'				align=center 	BgColor={decode(DOC_STATUS,'R','#FF0000','Y','#FFF000','G','#1DDB16','')}</C>	                    
					<C> id='DOC_NO'				width=80	name='문서번호'			align=center	</C>					
					<C> id='DOC_NM1'			width=100	name='대분류'			align=center	show=false</C>
					<C> id='DOC_NM2'			width=100	name='중분류'			align=center	show=false</C>
                    <C> id='DOC_NM3'			width=100	name='세부분류'			align=left		</C>
					<C> id='DOC_TITLE'			width=300	name='제목'				align=left	    </C>
					<C> id='DOC_REMARK'			width=240	name='설명'				align=left 		</C>
					<C> id='APP_STATUS'			width=80	name='결재상태'			align=center	value={decode(APP_STATUS_CD,'S','저장','G','결재진행중','R','반려','Y','결재완료','')}</C>
					<C> id='IPT_YMD'			width=80	name='입력일자'			align=center	mask='XXXX-XX-XX'</C>
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
		</td>
    </tr>
</table>


<br>

<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr valign="top">
		<td>
			<!-- 조건 입력 테이블 시작 -->
			<table width="320" border="0" cellspacing="0" cellpadding="0">
				<tr>
			        <td>
						<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
						
							<colgroup>
								<col width="150"></col>
								<col width="*"></col>
							</colgroup>
							
							<tr height="25">
								<td align="center" class="blueBold">문서번호</td>
								<td class="padding2423">
									<input id="txtDOC_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
                            </tr>
                            
                            <tr height="25">
								<td align="center" class="blueBold">소속</td>
								<td class="padding2423">
									<input id="txtDPT_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtDPT_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
                            <tr height="25">
								<td align="center" class="blueBold">직위</td>
								<td class="padding2423">
                                    <input id="txtJOB_CD" size="4" class="input_ReadOnly" readOnly>
                                    <input id="txtJOB_NM" size="10" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
							<tr height="25">
								<td align="center" class="blueBold">작성자</td>
								<td class="padding2423">
									<input id="txtENO_NO" size="7" class="input_ReadOnly" readOnly>
                                    <input id="txtENO_NM" size="7" class="input_ReadOnly" readOnly>
								</td>
							</tr>
							
							<tr height="25">
								<td align="center" class="blueBold">결재번호</td>
								<td class="padding2423">
                                    <input id="txtREQ_NO" size="17" class="input_ReadOnly" readOnly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 조건 입력 테이블 끝 -->
			
        </td>
        <td width="30">&nbsp;&nbsp;</td>
        <td>
        
        	<!-- 결재선 정보 테이블 시작 -->
			<table width="650" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td align="left">
						<comment id="__NSID__">
						<object	id="grdT_DI_APPROVAL" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:660px;height:127px;">
							<param name="DataID"				value="dsT_ACT_APPROVAL">
							<param name="Editable"              value="true">
							<param name="Format"				value="
                    			<C> id={currow}       	width=45   	name='No'	        align=center 	BgColor='#EEEEEE'</C>
								<C> id='ENO_NM'			width=90	name='결재자'		align=center	</C>
								<C> id='JOB_NM'			width=80	name='직위'			align=center	</C>
                                <C> id='DPT_NM'			width=100	name='소속'			align=center	</C>
								<C> id='APP_STATUS'		width=200	name='결재상태'		align=center    </C>
								<C> id='REMARK1'		width=100	name='의견'			align=center 	Color='Blue'	</C>
							">
						</object>
						</comment><script> __ShowEmbedObject(__NSID__); </script>
					</td>
                </tr>
            </table>
        	<!-- 결재선 정보 테이블 끝 -->
        </td>
    </tr>
</table>



<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>
                    <col width="180"></col>
					<col width="80"></col>					
					<col width=""></col>
				</colgroup>
				<tr>
                    <td align="center" class="blueBold">대분류</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB1" style="width:10%;ime-mode:inactive" maxlength="4" class="input_ReadOnly"  readonly> 
                        <input id="txtDOC_NM1" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB1','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB1" name="ImgDOC_GB1" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>

                    <td align="center" class="blueBold">중분류</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB2" style="width:10%;ime-mode:inactive" maxlength="4" class="input_ReadOnly"  readonly> 
                        <input id="txtDOC_NM2" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB2','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB2" name="ImgDOC_GB2" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    
                    <td align="center" class="blueBold">세부분류</td>
                    <td class="padding2423">
                        <input id="txtDOC_GB3" style="width:15%;ime-mode:inactive" maxlength="4" class="input_ReadOnly"  readonly> 
                        <input id="txtDOC_NM3" style="width:50%" class="input_ReadOnly"  readonly>
                        <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImgDOC_GB3','','../../images/button/btn_HelpOver.gif',1)">
                        <img src="../../images/button/btn_HelpOn.gif" id="ImgDOC_GB3" name="ImgDOC_GB3" width="21" height="20" border="0" align="absmiddle"></a>
                    </td>
                    
                    <td align="center" class="blueBold">진행상황</td>
                    <td class="padding2423" class="input_ReadOnly"  readonly>
						<select id="cmbDOC_STATUS" style="width:90%" class="input_ReadOnly"  readonly>
		                   <option value="" ></option>
		                   <option value="G">GREEN</option>
		                   <option value="Y">YELLOW</option>	
		                   <option value="R">RED</option>	               
						</select>	
                    </td>                    
                    
                </tr>


				<tr>
					<td align="center" class="blueBold">제목</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_TITLE" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>
				
				
				<tr>
					<td align="center" class="blueBold">설명</td>
					<td class="padding2423" colspan="7">
						<input id="txtDOC_REMARK" style="width:80%;ime-mode:inactive" size = "100" maxlength="200">
					</td>
				</tr>				
				
				
				<tr>
					<td align="center" class="blueBold">파일첨부</td>
					<td class="padding2423" colspan="7">
		                <comment id="__NSID__">
		                <object id="grdFILE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:65%;height:25px;">
		                    <param name="DataID" 			value="dsFILE">
		                    <param name="Editable" 			value="false">
		                    <param name="DragDropEnable" 	value="true">
		                    <param name="SortView" 			value="Left">
		                    <param name=ViewHeader  		value="false">
		                    <param name="Format" 			value='
		                        <C> id="{CUROW}"    width="30"      name="NO"         	align="center"  value={String(Currow)}</C>
		                        <C> id=FILE_NAME    width="500"     name="파일명"      	align="left"    leftmargin="10"</C>
		                    '>
		                </object>
		                </comment><script> __ShowEmbedObject(__NSID__); </script>

					</td>
				</tr>

			</table>
		</td>
	</tr>
</table>








</form>
<!-- form 끝 -->

</body>
</html>

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



<!--
**************************************************************
* 바인딩 컴포넌트
**************************************************************
-->
<!-- -->
<object id="bndT_ACT_PLANLIST" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ACT_PLANLIST">
	<Param Name="BindInfo", Value='
	

	
        <C>Col=DOC_STATUS     	Ctrl=cmbDOC_STATUS     		Param=value 	</C>
		<C>Col=DOC_NO     		Ctrl=txtDOC_NO     			Param=value 	</C>  
		
		<C>Col=ENO_NO     		Ctrl=txtENO_NO     			Param=value 	</C> 
		<C>Col=ENO_NM     		Ctrl=txtENO_NM     			Param=value 	</C>  
		<C>Col=DPT_CD     		Ctrl=txtDPT_CD     			Param=value 	</C> 	
		<C>Col=DPT_NM     		Ctrl=txtDPT_NM     			Param=value 	</C>  
		<C>Col=JOB_CD     		Ctrl=txtJOB_CD     			Param=value 	</C> 
		<C>Col=JOB_NM     		Ctrl=txtJOB_NM     			Param=value 	</C>  
		<C>Col=REQ_NO     		Ctrl=txtREQ_NO     			Param=value 	</C>  
		<C>Col=DOC_GB1     		Ctrl=txtDOC_GB1     		Param=value 	</C>
		<C>Col=DOC_NM1     		Ctrl=txtDOC_NM1     		Param=value 	</C>
        <C>Col=DOC_GB2     		Ctrl=txtDOC_GB2     		Param=value 	</C>
		<C>Col=DOC_NM2     		Ctrl=txtDOC_NM2     		Param=value 	</C>        
		<C>Col=DOC_GB3			Ctrl=txtDOC_GB3	   			Param=value		</C>
		<C>Col=DOC_NM3     		Ctrl=txtDOC_NM3     		Param=value 	</C>		
        <C>Col=DOC_TITLE		Ctrl=txtDOC_TITLE	   		Param=value		</C>
		<C>Col=DOC_REMARK   	Ctrl=txtDOC_REMARK    		Param=value		</C>


    '>
</object>


