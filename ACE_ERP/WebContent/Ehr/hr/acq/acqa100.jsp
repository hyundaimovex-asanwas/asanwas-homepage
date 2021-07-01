<!--*************************************************************************
* @source      : acqa100.jsp												*
* @description : Action Plan > Timetable > 얼마나 잘 쓰는지 두고보자!!!! 	*
*****************************************************************************
* DATE            AUTHOR        DESCRIPTION									*
*----------------------------------------------------------------------------
* 2019/03/13            이동훈       번갯불에 콩을 구워먹어도 유분수지		*
**************************************************************************-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page import="Ehr.common.util.JSPUtil" %>
<%@ page import="Ehr.common.*" %>

<html>
<head>
<title>Timetable</title>
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

        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

        	var ENO_NO_SHR = gusrid; 

            //trT_ACT_TIMETABLE.KeyValue = "tr(O:dsT_ACT_TIMETABLE=dsT_ACT_TIMETABLE)";
            //trT_ACT_TIMETABLE.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa100.cmd.ACQA100CMD&S_MODE=SHR";
            //trT_ACT_TIMETABLE.post();               

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

        	alert("담당자에게 문의바랍니다.");
			//if(!fnc_SaveItemCheck()) return;
            
			//trT_ACT_TIMETABLE_SAV.KeyValue = "tr(I:dsT_ACT_TIMETABLE=dsT_ACT_TIMETABLE)";
			//trT_ACT_TIMETABLE_SAV.action = "../../../servlet/GauceChannelSVL?cmd=Ehr.acq.a.acqa100.cmd.ACQA100CMD&S_MODE=SAV";
			//trT_ACT_TIMETABLE_SAV.post();

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

			//이곳에 해당 코딩을 입력 하세요.
			fnc_InputEnable();
			
			dsT_ACT_TIMETABLE.addRow();
			

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

			if (!dsT_ACT_TIMETABLE.IsUpdated ) {
                alert("변경된 자료가 없습니다.");
                fnc_Message(document.getElementById("resultMessage"), 'MSG_04');
                return false;
			}          
            
            if(document.getElementById("txtDOC_TITLE").value == ""){
            	alert("문서 제목을 입력하시기 바랍니다.");
            	document.getElementById("txtDOC_TITLE").focus();
            	return false;
            }

            if(dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY") == ""){
            	alert("파일을 첨부하시기 바랍니다.");

            	return false;
            }
            
			return true;

        }

        

        
        /********************************************
         * 14. Form Load 시 Default 작업 처리 부분  *
         *******************************************/
        function fnc_OnLoadProcess() {

			//첫번째 인수 : 그리드명                             두번째 인수 : Row Head 표시여부(0:미표시, 15:표시)
			//세번째 인수 : 그리드모드(false:읽기, true:쓰기)    네번째 인수 : sort기능 사용여부(false:미사용, right:sort사용)
			cfStyleGrid_New(form1.grdT_ACT_TIMETABLE,0,"false","true");      // Grid Style 적용		
			
			fnc_SearchList();
			
            fnc_InputDisabled();//입력란 disabled			

        }



		
        /***********************************
         *    	입력란 Disabled처리  		*
         ***********************************/
		function fnc_InputDisabled() {

            document.getElementById("txtDOC_TITLE").className = "input_ReadOnly";
            document.getElementById("txtDOC_TITLE").readOnly = true;
            document.getElementById("txtDOC_REMARK").className = "input_ReadOnly";
            document.getElementById("txtDOC_REMARK").readOnly = true;

        }

        
        /***********************************
         *    	입력란 Enable처리    		*
         ***********************************/     
        function fnc_InputEnable() {
        	        	
            document.getElementById("txtDOC_TITLE").className = "";
            document.getElementById("txtDOC_TITLE").readOnly = false;
            document.getElementById("txtDOC_REMARK").className = "";
            document.getElementById("txtDOC_REMARK").readOnly = false;

        }

        
        /********************************************
         * 				첨부파일 처리				*
         ********************************************/
		function fnc_FileUpload() {
        	
            if(dsFILE.CountRow == 1) {
            	
                alert("더 이상 첨부파일을 추가하실 수 없습니다.");
                
                return;
                
            }

            var key = dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY");

            if(key == "") {
            	
                key = "acqa100"+(new Date().getTime());
                
                dsT_ACT_TIMETABLE.NameValue(dsT_ACT_TIMETABLE.RowPosition, "FILE_KEY") = key;
                
            }

            if(!fnc_AddFileImg(key)) {
            	
                return;
                
            }
            
		}

        
		/********************************************
         * 				첨부파일 삭제				*
         ********************************************/
		function fnc_FileDelete() {
			
            if(dsFILE.CountRow < 1) {
            	
                alert("삭제할 파일이 존재하지 않습니다.");
                
                return;
                
            }

            

           if( confirm("첨부된 파일을 삭제하시겠습니까?") ){
           	
               dsFILE.DeleteRow(dsFILE.RowPosition);
               
               fnc_DelFile();
               
           }
            
            	

            
		}

		


    </script>

    </head>




    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <Object ID="dsT_ACT_TIMETABLE" ClassID="CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB">
        <Param Name="Syncload"        Value="True">
        <Param Name="UseChangeInfo"   Value="True">
        <Param Name="ViewDeletedRow"  Value="False">
    </Object>
    

    



    <!------------------------------------------------------+
    | 1. 자료 저장 및 조회용 Data Transacton			    |
    | 2. 이름은 tr_ + 주요 테이블명(trT_ACT_TIMETABLE)	    |
    | 3. 사용되는 Table List(T_ACT_PLAN)	                |
    +------------------------------------------------------->
    <Object ID ="trT_ACT_TIMETABLE" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>

    <Object ID ="trT_ACT_TIMETABLE_SAV" ClassID="CLSID:78E24950-4295-43D8-9B1A-1F41CD7130E5">
            <Param Name=KeyName     Value="toinb_dataid4">
    </Object>
    

    
    <!--*************************************
    *                                       *
    *  Component에서 발생하는 Event 처리부  *
    *                                       *
    **************************************-->

    <!-----------------------------------------------------+
    | 			Transaction Successful 처리  			   |
    +------------------------------------------------------>
    
    <script for=trT_ACT_TIMETABLE event="OnSuccess()">

  
        
    </script>    
    
  
    <!-----------------------------------------------------+
    | 			Transaction Failure 처리  			   	   |
    +------------------------------------------------------>
    <script for=trT_ACT_TIMETABLE event="OnFail()">
    
        cfErrorMsg(this);
        
    </script>


    <!-----------------------------------------------------+
    | Grid 클릭시 진행상태에 따른 버튼 및 필드 활성화 처리 |
    +------------------------------------------------------>
    <script language=JavaScript for=dsT_ACT_TIMETABLE event=OnRowPosChanged(row)>    	
        	
        if(row > 0) {
        	
            //등록된 파일들 조회
            fnc_GetFileList(dsT_ACT_TIMETABLE.NameValue(row, "FILE_KEY"));              

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
		<td class="paddingTop5" align="right" >

            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgNew','','../../images/button/btn_AddnewOver.gif',1)">    
            	<img src="../../images/button/btn_AddnewOn.gif"   name="imgNew"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_AddNew()">
            </a>
            <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('imgSave','','../../images/button/btn_SaveOver.gif',1)">    
            	<img src="../../images/button/btn_SaveOn.gif"   name="imgSave"   width="60" height="20" border="0" align="absmiddle" onClick="fnc_Save()">
            </a>
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->


<!-- 조건 입력 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
        <td class="paddingTop5">
			<table width="100%" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse" bordercolor="#999999" class="table_cream">
				<colgroup>
					<col width="80"></col>				
					<col width=""></col>
				</colgroup>

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
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileAdd','','../../images/button/FileAddOver.gif',1)">
							<img src="../../images/button/FileAddOn.gif" name="FileAdd" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileUpload()">
						</a>
						<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('FileDel','','../../images/button/FileDelOver.gif',1)">
							<img src="../../images/button/FileDelOn.gif" name="FileDel" width="80" height="20" border="0" align="absmiddle" onclick="fnc_FileDelete()">
						</a>
		
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- 조회 상태 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="paddingTop3">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td valign="top" class="searchState"><span id="resultMessage">&nbsp;</span></td>

				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 조회 상태 테이블 끝 -->

<font color="blue" size="2"><b>[Document List]</b></font>

<!-- 문서 현황 정보 테이블 시작 -->
<table width="1000" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="left">
			<comment id="__NSID__">
			<object	id="grdT_ACT_TIMETABLE" classid="clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B" style="width:1000px;height:500px;">
				<param name="DataID"				value="dsT_ACT_TIMETABLE">
				<param name="Editable"              value="false">
				<param name="SortView" 				value="Left">				
				<param name="Format"				value="
                    <C> id={currow}       	 	width=50   	name='No'	         	align=center 	BgColor='#EEEEEE'</C>
					<C> id='FILE_KEY'			width=100	name='FILE_KEY'			align=center	show=false</C>	
					<C> id='DOC_TITLE'			width=400	name='제목'				align=left	    </C>
					<C> id='DOC_REMARK'			width=400	name='설명'				align=left 		</C>
					<C> id='IPT_YMD'			width=120	name='입력일자'			align=center	mask='XXXX-XX-XX'</C>
				
				">
			</object>
			</comment><script> __ShowEmbedObject(__NSID__); </script>
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
<object id="bndT_ACT_TIMETABLE" classid="CLSID:4A35BB2C-B831-4199-A486-FEA332D085D9">
	<Param Name="DataID",   Value="dsT_ACT_TIMETABLE">
	<Param Name="BindInfo", Value='
		<C>Col=DOC_NO     		Ctrl=txtDOC_NO     			Param=value 	</C>  
        <C>Col=DOC_TITLE		Ctrl=txtDOC_TITLE	   		Param=value		</C>
		<C>Col=DOC_REMARK   	Ctrl=txtDOC_REMARK    		Param=value		</C>
    '>
</object>


