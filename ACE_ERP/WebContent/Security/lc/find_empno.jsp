<!--
***********************************************************************
* @source      : find_empno.jsp
* @description : 사원정보조회 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2017/08/08            이동훈            	ERP 이사									 *
***********************************************************************
-->
<%@ page import="security.common.*" %>
<%@ page contentType="text/html;charset=euc-kr"%>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>



<html>

<head>
<jsp:include page="/Security/common/include/head.jsp"/>
<title>사원정보조회</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<script language=javascript src="../../../Ehr/common/common.js"></script>	    

    <!--*****************************
    *  자바스크립트 함수 선언부분  *
    *****************************-->
    <script language="javascript" >

    
        var retObj = window.dialogArguments;
        
        //반환할 데이타 초기화
        retObj.eno_no ='';
        retObj.eno_nm ='';        
        
        /***********************************
         * 01. 조회 함수_List 형태의 조회  *
         ***********************************/
        function fnc_SearchList() {

            //데이터셋 전송
    		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,v_enono=" + document.getElementById("txtENO_NO").value;
    		
    	    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_LI%>Find_empno",  "JSP(O:dsT_CM_PERSON=dsT_CM_PERSON)",  param);

    	    tr_post(tr1);            

        }


</script>

</head>


    <!--**************************************************************************************
    *                                                                                        *
    *  Non Visible Component 선언부(해당 폼에서 사용되는 모든 컴퍼넌트를 이곳에 정의 하세요) *
    *                                                                                        *
    ***************************************************************************************-->

    <!----------------------------------------------+
    | 1. 조회 및 저장용 DataSet                     	|
    | 2. 이름은 ds_ + 주요 테이블명()      			|
    | 3. 사용되는 Table List()             				|
    +----------------------------------------------->
	<object  id=dsT_CM_PERSON classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="SyncLoad" 				VALUE="false">
	    <Param Name="UseChangeInfo"   			Value="True">
	    <Param Name="ViewDeletedRow"  		Value="False">
	</object>
	
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
	<comment id="__NSID__">
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="KeyName"    		value="toinb_dataid4">
	    <param name="ServerIP"   			value="">
	    <param name="Action"     			value="">
	    <param name="KeyValue"   			value="">
	    <param name="Parameters" 			value="">
	</object>
	</comment><script>__ws__(__NSID__);</script>	
	
	
    <!--*************************************
    *                                       		*
    *  Component에서 발생하는 Event 처리부  *
    *                                       		*
    **************************************-->

    <!-------------------------------------------------+
    | 데이터를 성공적으로 조회 되었을 때 처리 할 로직  |
    +-------------------------------------------------->
    <Script For=dsT_CM_PERSON Event="OnLoadCompleted(iCount)">

        if (iCount < 1)    {

            document.getElementById("txtENO_NO_SHR").focus();          //검색 1조건에 Focus

        } else {

            grdT_CM_PERSON.SetColumn("ENO_NO");//set focus

        }

    </Script>

    <!-----------------------------------------------------+
    | 데이터를 조회 중 오류가 발생하였을 때 처리하는 로직  |
    +------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnLoadError()">

        cfErrorMsg(this);

    </Script>

    <!-----------------------------------------------------------------+
    | 데이터을 신규 혹은 추가 작업을 할 때 Header가 없어 오류가 날 때  |
    +------------------------------------------------------------------>
    <Script For=dsT_CM_PERSON Event="OnDataError()">

        cfErrorMsg(this);

    </Script>

    <!-------------------------------+
    | 그리드의 ROW를 더블 클릭 할때  |
    +-------------------------------->
    <script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');

		//alert(retObj.eno_no);
		//alert(retObj.eno_nm);  
		
		window.returnValue = retObj.eno_no +";"+ retObj.eno_nm;		

        window.close();

    </script>

    <!-------------------------------+
    | 그리드의 ROW에서 엔터 입력할때|
    +-------------------------------->
    <script language=JavaScript for=gcgd_disp01 event=OnReturn(row,colid)>

        var retObj = window.dialogArguments;

        retObj.eno_no   = dsT_CM_PERSON.NameValue(row,'ENO_NO');
        retObj.eno_nm   = dsT_CM_PERSON.NameValue(row,'ENO_NM');
        
		//prompt(this, retObj);
        
        window.close();

    </script>


<!--
**************************************************************
* BODY START
**************************************************************
-->
<body>

<br><br>

<!-- 버튼 테이블 시작 -->
<table width="435px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td align=right >
			<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnc_SearchList();">
		</td>
	</tr>
</table>
<!-- 버튼 테이블 끝 -->

<br>

<!-- power Search테이블 시작 -->
<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:435px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="100px;" class="tab25"  bgcolor="#eeeeee" align=center>사원 번호/성명&nbsp;</td> 
		<td class="tab24" >&nbsp;
                   <input name="txtENO_NO" id="txtENO_NO" size="20" maxlength="20" onkeypress="javascript:if(event.keyCode==13) fnc_SearchList()">
		</td>	
	</tr>
</table>
<!-- power Search테이블 끝 -->

<br>

<!-- 내용 조회 그리드 테이블 시작-->
<table width="435" border="0" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;top:0px;">
		<tr> 
			<td>
				<comment id="__NSID__">
							<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  style="position:relative;left:0px;width:435px; height:350px; border:1 solid #708090;display:block;" viewastext>
									<param name="DataID"		 		value="dsT_CM_PERSON">
									<param name="IndWidth"		 	value='0'>
									<param name="BorderStyle"  		value="0">
									<param name="Fillarea"		 		value="true">
									<param name="Sortview"		 		value="left">
									<param name="ColSizing"	 		value="true">
									<param name="Editable"		 		value="False"> 
									<param name=TitleHeight      		value="20">
				                    <param name="SuppressOption"   value="1">						
									<param name="Format"	 	 		value=" 
                                    <C> id=HEAD_NM           width=100  name=본부   align=left   </C>
                                    <C> id=DPT_NM             width=90    name=부서   align=left   </C>
                                    <C> id=JOB_NM             width=80    name=직위   align=left   </C>
                                    <C> id=ENO_NO             width=80    name=사번   align=center </C>
                                    <C> id=ENO_NM             width=80    name=성명   align=center </C>
									">
							</object>
					</comment><script>__ws__(__NSID__);</script>
              </td>
       </tr>
</table>
<!-- 내용 조회 그리드 데이블 끝-->

<!-- 조회 상태 테이블 시작 -->
<table width="380" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="paddingTop8">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td valign="top" class="searchState">* 해당항목을 더블클릭 하시면 선택됩니다.</span></td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
<!-- 조회 상태 테이블 끝 -->


</body>
</html>

