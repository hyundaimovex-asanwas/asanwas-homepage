<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * 시스템명 	 : 매입등록 - 원천징수
 * 프로그램ID 	 : PMS/Sta
 * J  S  P		 : Sta400.jsp
 * 서 블 릿		 : Sta400
 * 작 성 자		 : 이 동 훈
 * 작 성 일		 : 2018-06-21
 * 기능정의		 : 매입등록 - 원천징수
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import 시작
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath 변수 설정.
	String dirPath = request.getContextPath(); //HDASan
%>

<!-- HTML 시작-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/


	var gs_userid = gusrid;
	var gs_fdcode;
	
	var gstrempno="";
	var gstrdeptcd="";
	var gstrGubun ="";
	var gstrAuthgr="";
	var gstrRowpos="";




	var v_default_row = 1;
	
	var v_job = ""; //Transaction Job의 속성변수. S:조회, I:초기, N:신규, SD:디테일조회, A:적용
	
	
	<%//페이지로딩 %> 
	function fnOnLoad(tree_idx){
		
		fnInit_tree(tree_idx);	//트리초기화 호출
	
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		
		fnInit();
		
	}
	
	<%//초기작업 %>
	function fnInit() {
		
	    v_job ="I";
	    
	    v_fr_date.Text = "<%=DateUtil.getCurrentDate(8).substring(0,6)+"01"%>";
        v_to_date.Text = "<%=DateUtil.getCurrentDate(8)%>";		
		
		
    	//지점코드
    	ds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
    	ds_fdcode.Reset();


		fnSelect();
	    
	}

	
	

	
	
    <%//메인 조회  %>
    function fnSelect() {
    	
		    v_job="S";

	        var fr_date = v_fr_date.Text.trim();
	        var to_date = v_to_date.Text.trim();

	        if(fr_date.length!=8) {
	            alert("일자(From)를 입력하시길 바랍니다.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("일자(To)를 입력하시길 바랍니다.");
	            return;
	    	}

	                  
	    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
									                + ",v_frdt=" + fr_date						//from
									                + ",v_todt=" + to_date   					//to
	                  								+ ",v_vendor_cd="  + v_vendor_cd.value	    //거래처코드              								
													+ ",v_eno_no="  + v_eno_no.value;			//작성자사번
	                  								
	        //alert(param);

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_STA%>Sta400",
				            "JSP(O:DS_DEFAULT=ds_default)",
				            param);
	           
	        tr_post(tr1);
	        

    }    	
	




	<% //거래처코드 %>
	function fnSelect_vendor(dirPath){
		
	    var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
	

		strURL = dirPath+"/Account/jsp/gczm_vender_popup.jsp";
		
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		
		arrResult = showModalDialog(strURL,arrVAT,strPos);
		
		
		if (arrResult != null) {
			
			arrParam = arrResult.split(";");

    		v_vendor_cd.value = arrParam[0];
    		v_vendor_nm.value = arrParam[1];			

			
		} else {
			
    		v_vendor_cd.value = "";
    		v_vendor_nm.value = "";				

		}
		
	}





    <%//직원 팝- 검색조건 처리자 : 관리자만 가능하게%>
    function fnEmpNoPopup(dirPath){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;
		
    	strURL = dirPath+"/Account/jsp/empno_popup2.jsp";
    	
    	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	
    	if (arrResult != null) {
    	   	//alert(arrResult);//EMPNMK, EMPNO, DEPTNM, PAYGNM,DEPTCD
    		arrParam = arrResult.split(";");
    		
    		v_eno_no.value = arrParam[1];
    		v_eno_nm.value = arrParam[0];

    		
        } else {
        	
			fnEmpNoCleanup();
			
        }               
    	
    }

    
    
    <%	//작성자 삭제	%>
    function fnEmpNoCleanup(){
    	
        v_eno_no.value = "";
        v_eno_nm.value  = "";
        
    }






	<%	//전표조회 		%>
	function ln_Slipno(){
		
		if(gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") != "") {	
			
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL="";	
			var strPos="";
	
			arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
			arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FSDAT");
			arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"FSNBR");
	
			strURL = "/Account/jsp/slipno_popup.jsp";
			
			strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
			
			arrResult = showModalDialog(strURL,arrParam,strPos);
			
		}else if (gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") == "") {
			
			alert("발행 된 전표가 없습니다.");
			
		}
		
	
	}

	
	
	
    <%//전표 발행 클릭시%>
    function fnStateCreate(){
    	
    	var arrParam	= new Array();
    	var arrResult	= new Array();
    	var strURL;	
    	var strPos;

		strURL = "<%=dirPath%>/Pms/new/sta/sta310.jsp";
		
    	strPos = "dialogWidth:1050px;dialogHeight:800px;status:no;scroll:no;resizable:no";
    	
    	arrResult = showModalDialog(strURL,'',strPos);
    	
    	if (arrResult != null) {
    		
        } else {

        }    
        
        
    }



</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>


<object  id="ds_fdcode" classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[검색] -->
</object> 



<object id=ds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>




<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript  for=ds_default event=OnLoadCompleted(row,colid)>

		window.status = "정상적으로 조회되었습니다.";
		
		if (row<1) 
			alert("검색된 데이터가 없습니다.");
</script>





<script language="javascript" for="ds_fdcode" event="onloadCompleted(row,colid)">

	ds_fdcode.InsertRow(1);
	
	ds_fdcode.NameValue(1,"FDCODE")="";
	
	ds_fdcode.NameValue(1,"FDNAME")="전체";
	
	lc_fdcode.bindcolval=gs_fdcode;
	
</script>



<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript"  for=ds_default  event="OnDblClick(Row,Colid)">

	
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>


<table width="1000" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">

        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='1000px'>
                    <tr>
						
			     		<td align=left >&nbsp;&nbsp;&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/sta_issue.gif"				style="cursor:pointer" onClick="fnStateCreate();">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"					style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"					style="cursor:pointer" onClick="fnApply();">							
							<img src="<%=dirPath%>/Sales/images/new.gif"					style="cursor:pointer" onClick="fnNew();">	
                        </td>					
						
                    </tr>
                </table>
            </td>
        </tr>

	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>

            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='1000px'>
           			<tr>

                        <td align=left class="text"  width="80">기간</td>
                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_fr_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>&nbsp;~&nbsp;
                            <object id=v_to_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
                                <param name=Text        			value="">
                                <param name=Alignment   			value=1>
                                <param name=Format      			value="0000-00-00">
                                <param name=Cursor      			value="iBeam">
                                <param name=Border      			value="false">      
                                <param name=InheritColor      		value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    			value="false">
                                <param name=SelectAll   			value="true">
                                <param name=SelectAllOnClick    	value="true">
                                <param name=SelectAllOnClickAny   	value=false>
                            </object>
                            <%=HDConstant.COMMENT_END%>                                                                             
                        </td>           			

                        <td align="left" class="text" width="80">지점코드</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_fdcode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=ComboDataID			value="ds_fdcode">
								<param name=CBDataColumns		value="FDCODE,FDNAME">
								<param name=SearchColumn		value="FDNAME">
								<param name=Sort				value=false>
	              				<param name=Enable              value="true">
								<param name=ListExprFormat	    value="FDNAME^0^100">
								<param name=BindColumn			value="FDCODE">
								<param name=Index               value="2">                            
                            </object>
                        </td>                         
                               
                        <td align="left" class="text" width="80">사업소</td>
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=lc_cocode classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=CBData				value="^전체,01^고성,02^서울,04^홍성">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
                            </object>            
                        </td>     
                     
                  
					</tr>

           			<tr>
                        <td align="center" class="text" width="80">거래처</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_vendor_cd' id="v_vendor_cd" style="width:60px;" class='input01'  readOnly="readonly" value="">                                                	
                        	<input type="text" name='v_vendor_nm' id="v_vendor_nm" style="width:150px;" class='input01'  readOnly="readonly" value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelect_vendor('<%=dirPath%>');" alt="거래처 찾기">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>


                        <td align="center" class="text" width="80">작성자</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                        	<input type="text" name='v_eno_no' id="v_eno_no" style="width:60px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrid")%>">                        
                        	<input type="text" name='v_eno_nm' id="v_eno_nm" style="width:100px;" class='input01'  readOnly="readonly" value="<%=(String)session.getAttribute("vusrnm")%>">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnEmpNoPopup('<%=dirPath%>');" alt="직원 찾기">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnEmpNoCleanup();" alt="값 지우기">
                        </td>       

                        <td align="center" class="text" width="80">전표상태</td>
                        <td bgcolor="#FFFFFF">&nbsp;
                            <object id=lc_fsstat classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  align=absmiddle>
								<param name=CBData					value="^전체,Y^결재완료,C^결재취소,R^결재요청,N^결재대기,B^반송,X^결재완료이외">
								<param name=CBDataColumns			value="CDCODE,CDNAM">
								<param name=SearchColumn			value="CDNAM">
								<param name=Sort					value=false>
								<param name=ListExprFormat	    	value="CDNAM^0^100">
								<param name=BindColumn				value="CDCODE">
								<param name=index					value="0">
                            </object>
                        </td>                        
					</tr>
           		</table>
            </td>	
	</tr>
	

  <tr>
	  <td height=10>&nbsp;
	  </td>
  </tr>
  
  
  <tr>
      <td valign="top">
          <table  border='0' cellpadding='0' cellspacing='0'>
              <tr>
                  <td valign='top' width="1000px">
                      <%=HDConstant.COMMENT_START%>
                      <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='1000px' height='580px' border='1'>
                          <param name="DataID"            value="ds_default">
                          <param name="ColSizing"         value="true">
                          <param name="Editable"          value="true">
                          <param name="SuppressOption"    value="1">
                          <param name="BorderStyle"       value="0">
                          <param name="ViewSummary"       value="1">
                          <param name="Format"            value="
							<C>ID=CHK,				Name='선택'				width=30, 	align=center, EditStyle=CheckBox BgColor='#f5f5f5'</C>
							<C>ID=FDNAME, 			Name='지점'				width=30, 	align=left,   Edit=none show=false</C>
							<C>ID=FSSTAT,			Name='전표상태'			width=75,  align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true show=false</C>
							
							<C>ID=PL_DEPT_NM,		Name='귀속구분'			width=130, align=LEFT    Edit=none sort=true </C>							
							
							<C>ID=PLJ_NM,			Name='원가코드'			width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=ATKORNAM,			Name='계정명'			width=135, align=LEFT    Edit=none sort=true SumText='합계'</C>
														
							<C>ID=SSNBR,			Name='전표번호'			width=115, 	align=center, Edit=none sort=true mask='XXXXXXXXX-XXXXXX' show=false</C>
							<C>ID=FSNBR,			Name='접수번호'			width=115,  align=center  Edit=none sort=true mask='XXXXXXXXX-XXXXXX' show=false</C>
														
							<C>ID=VEND_CD,			Name='거래처코드'		width=80,  	align=center, BgColor='#f5f5f5' 	Edit=none show=false </C>
				                       
							<C>ID=VEND_NM,			Name='거래처명'			width=95,  	align=LEFT,   BgColor='#f5f5f5' 	Edit=none sort=true </C>
							<C>ID=VEND_ID,			Name='사업자번호'		width=90,  	align=center, mask='XXX-XX-XXXXX'	Edit=none sort=true </C>

							<C>ID=TAXTOT,			Name='합계금액'			width=95,  align=right   Edit=none sort=true  sumtext=@sum</C>		                             
        
							<C>ID=REMARK,			Name='적요'				width=135, align=LEFT    Edit=none sort=true </C>
							<C>ID=TAXKNDNM,			Name='종류'	     		width=45,  align=center  Edit=none sort=true show=false</C>

							<C>ID=DEPTNM,			Name='담당부서'			width=70,  align=left    Edit=none sort=true show=true </C>
							<C>ID=EMPNMK,			Name='담당자'			width=65,  align=center  Edit=none sort=true show=true </C>

							<C>ID=DUEDATE,  		Name='입금예정일'		width=90,  align=center  Edit=none sort=true show=fals mask='XXXX-XX-XX' show=false</C>
							<C>ID=TAXSTS,	 		Name='결재상태'	  		width=75,  align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true show=false</C>
									                             
                       ">
                      </object>   
                      <%=HDConstant.COMMENT_END%>
                    </td>
                </tr>
            </table>
		</td>
    </tr>
</table>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 