<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �޿��ý���
 * ���α׷�ID 	: P03000
 * J  S  P		: P030009i
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������		:	ds1) �⺻���� + ��Ÿ���� �Ϻ�
 					ds2) �����ٹ��� 
					ds3) ��������
					ds4) ���
 *                   
 * ������������ 	: 2007-01-11
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
    
    eyy="2006";
%>


<HTML>
<HEAD>
<TITLE>2006�� �ٷμҵ���� �Ű� �Է�</TITLE>
<META http-equiv=Content-Type content="text/html; charset=euc-kr">
<LINK href="imgs/css_ehr.css" type=text/css rel=stylesheet>

<!-- ���� ���콺 ����-->
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../common/include/PubFun.js"></script>

<script language="javascript" src="js/PubFun.js"></script>
<script language="javascript" src="js/embedControl.js"></script>
<script language="javascript" src="js/menu.js"></script>
<script language="javascript" src="js/common_gauce.js"></script>
<script language="javascript" src="js/common_pop.js"></script>      
<script language="javascript" src="js/common.js"></script>       
<SCRIPT language=JavaScript src="imgs/web.js"></SCRIPT>
<SCRIPT language=JavaScript src="imgs/06YearEntry.js"></SCRIPT>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //���
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
	//var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
	function ln_Start(){
		//�׸��� ��Ÿ�� �ֱ�
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");		
		cfStyleGrid(getObjectFirst("gr3"), "comn");				

		//�����ͼ� ��� ����
		ln_SetDataHeader();
			
		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (���μҵ� + ���)
		fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�����ٹ�)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
		fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��α�)		
	}
	
	function ln_SetDataHeader(){
//		var s_temp = "VD_FAXNO:DECIMAL,POST_NO1:STRING,POST_NO2:STRING,ADDRESS1:STRING,VEND_ID:STRING";
		var s_temp = "REFc1:DECIMAL,REFc2:DECIMAL";
		ds3.SetDataHeader(s_temp);
	}	

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno) {	 //�⺻ ��ȸ
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);
			tr_post(tr1);
	}

	function fnSelect2(pYear, pEmpno) {	 //�����ٹ���
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS2=ds2)",
			    param);
			tr_post(tr1);
	}	
	
	function fnSelect3(pYear, pEmpno) {	 //��������
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS3=ds3)",
			    param);
			tr_post(tr1);
	}	

	function fnSelect4(pYear, pEmpno) {	 //��α�
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;

			ln_TRSetting(tr1, 
			    "../services/servlet/Payroll.p030009i",	//	
			    "JSP(O:DS4=ds4)",
			    param);
			tr_post(tr1);
	}	
	
	
/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
    function fnApply() {// ���� �����ͼ� �ݿ�
		v_job = "I";	
        if (ds1.IsUpdated) {
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�⺻���� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 

	function fnAddRow3(){
		ds3.addrow();	
		ds3.namevalue(ds3.rowposition, "APPDT")="<%=eyy%>12";
		ds3.namevalue(ds3.rowposition, "EMPNO")="<%=eno%>";		

	};
	function fnDeleteRow3() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds3.DeleteRow(ds3.RowPosition);
	}

    function fnApply3() {// ���� �����ͼ� �ݿ�
		v_job = "I";	
        if (ds3.IsUpdated) {
        
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "../services/servlet/Payroll.p030009i",
                "JSP(I:DS3=ds3,O:RESULT=ds_result)",	//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�������� ������ ���� ������ �����ϴ�.");
        }
    };

	function fnCancel3() {	//��ҽ� undo all. 
		ds3.undoall();
	};



/******************************************************************************
	Description : �� �˾�â ����
******************************************************************************/
function openOfc(){
	dest = "P030009_ofc1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"ofc", "left=0,top=0,width=704,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openInsu(juno){
	dest = "P030009_insu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=800,height=540,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openMedi(juno){
	dest = "P030009_medi1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=1000,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openEdu(juno){
	dest = "P030009_edu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=900,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openCard(juno){
	dest = "P030009_card1.jsp?eyy=<%=eyy%>&eno=<%=eno%>&eJuno="+juno;
	window.open(dest,"ofc", "left=0,top=0,width=840,height=660,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

function openGibu(){
	dest = "P030009_gibu1.jsp?eyy=<%=eyy%>&eno=<%=eno%>";
	window.open(dest,"gibu", "left=0,top=0,width=1004,height=600,menubar=no,status=yes,titlebar=yes,toolbar=no,scrollbars=yes,resizable=yes" );
}

</script>

<script language=javascript for="gr3" event="OnClick(Row, Colid)">
//�������� Ŭ���� �� �˾� ����

    if(Row<1){
     return;
    }

    if ( (Colid =="REF11") || (Colid =="REF21") || (Colid =="REF12") || (Colid == "REF22")||(Colid =="REF13") || (Colid == "REF23")||(Colid =="REF14")||(Colid == "REF24") ) {
	    if (ds3.namevalue(ds3.rowposition, "RESINO1").length < 13) {
	    	alert("�������� ����������� ���� �Է�/���� �� ���Է�â�� ����ּ���.");
	    	return;
	    };
    };
    
    
    if ((Colid =="REF11") || (Colid =="REF21")) {
//    	alert("�����");
    	openInsu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF12") || (Colid == "REF22")) {
//    	alert("�Ƿ��");    
		openMedi(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF13") || (Colid == "REF23")) {	
//    	alert("������");    
		openEdu(ds3.namevalue(ds3.rowposition, "RESINO1"));
    } else if ((Colid =="REF14") || (Colid == "REF24")) {
//    	alert("ī��/��");    
		openCard(ds3.namevalue(ds3.rowposition, "RESINO1"));
	}

//    alert(ds3.namevalue(ds3.rowposition, "REF11"));
//REF11,21,12,22,13,23,14,24
	
	    
</script>

<script language="javascript" for="tr1" event="onsuccess()">
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
//		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (���μҵ� + ���)
//		fnSelect2("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�����ٹ�)
		fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
//		fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��α�)		

		
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
    };	
	// ������� �׽�Ʈ �Ϸ� : ds_result�� ���� ���� �� ���־�� ������ �ȳ���.~
</script>



<script language=JavaScript  for=ds_result event="OnLoadCompleted(row)" >
// ��� �޼��� Ȯ��...
    if(row==0) return;
    var v_yn = "";
    var v_msg = "";
    for(var i=1; i<=row; i++){
        if(ds_result.NameValue(i, "MSG_CD")!="0000"){
            v_msg += ds_result.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_msg!=""){
        alert(v_msg);
    }
</script>
<script language=javascript for=ds_result event="OnLoadCompleted(Row)">
if(Row==0) return;
</script>
<%=HDConstant.COMMENT_START%>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �޼��� -->
    <param name="SyncLoad"  value="false">
</object>
<%=HDConstant.COMMENT_END%>




<BODY text=#000000 bgColor=#ffffff style='padding:0px' OnLoad="ln_Start()"> 
<FORM name=entry action="" method=post>
	<INPUT type=hidden value=2006 name=eyy> 
	<INPUT type=hidden value=200089 name=eno> <!-- ��� -->

<%=HDConstant.COMMENT_START%>
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='���'				ID=APPDT   		Width=63	</C>    
	<C> Name='���'				ID=EMPNO  		Width=60	</C>    
	<C> Name='�ҼӺμ�'			ID=DEPTCD  		Width=60	</C>    
	<C> Name='����'				ID=PAYGRD  		Width=60	</C>    
	<C> Name='�׷��Ի���'			ID=JOINDATE  	Width=60	</C>    
	<C> Name='����'				ID=EMPNMK  		Width=40	</C>    
	<C> Name='�ֹι�ȣ'			ID=EMPJUNO  	Width=60	</C> 	
	<C> Name='��ȭ��ȣ'			ID=TELNUM	  	Width=60	</C>
	<C> Name='�ּ�'				ID=ADDRESS  	Width=60	</C>
	<C> Name='�����޿�'			ID=TAX_PAY  	Width=60	</C>
	<C> Name='������'			ID=TAX_BNS  	Width=60	</C>
	<C> Name='�����ҵ��'			ID=TAX_SUM  	Width=60	</C>
	<C> Name='������ҵ��'		ID=NTAX_SUM  	Width=60	</C>
	<C> Name='���ټ�'  			ID=DEDUCT1 		Width=60	</C>	
	<C> Name='�ֹμ�'  			ID=DEDUCT2 		Width=60	</C>	
	<C> Name='���ο���'			ID=DEDUCT3 		Width=60	</C>                                                             
	<C> Name='�ǰ�����'			ID=DEDUCT4 		Width=60	</C>
	<C> Name='��뺸��'			ID=DEDUCT5  	Width=60	</C>
	
	<C> Name='���ø��������'		ID=HOUAMT01 		Width=63	</C>    
	<C> Name='�������Աݻ�ȯ'		ID=HOUAMT02 		Width=60	</C>    
	<C> Name='������������6'		ID=HOUAMT03 		Width=60	</C>    
	<C> Name='������������10'		ID=HOUAMT04 		Width=60	</C>    
	<C> Name='�����ڱݰ�'			ID=HOUSUM 	     	Width=60	</C>    
	<C> Name='��αݰ�'			ID=CONSUM	 		Width=60	</C>
	<C> Name='���ο���'			ID=ETCAMT011    	Width=40	</C>    
	<C> Name='��������'			ID=ETCAMT01 		Width=60	</C>
	<C> Name='�������Ա�(����'		ID=DEDAMT03 		Width=60	</C>
	<C> Name='��ġ��α�(����'		ID=DEDAMT04		Width=60	</C>	
	
	<C> Name='Flag'	    		ID=FLAGCOL		Width=20	</C>		
	">
</OBJECT>	

<OBJECT id=gr2  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds2">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='�ٹ�ó��'			ID=BF_WKNM     			Width=60	</C>    
	<C> Name='����ڵ�'			ID=BF_RESINO			Width=60	</C> 
	<C> Name='�����޿�'			ID=BF_TAX_PAY			Width=60	</C>    
	<C> Name='������'			ID=BF_TAX_BNS			Width=60	</C> 
	<C> Name='�����ҵ�'			ID=BF_TAX_SUM 			Width=60	</C>    
	<C> Name='�������'			ID=BF_NTAX_SUM 			Width=60	</C> 
	<C> Name='�����ҵ�'			ID=BF_DEDUCT1   		Width=60	</C>    
	<C> Name='�����ֹ�'			ID=BF_DEDUCT2			Width=60	</C> 
	<C> Name='���ο���'			ID=BF_DEDUCT3			Width=60	</C>    
	<C> Name='�ǰ�����'			ID=BF_DEDUCT4			Width=60	</C> 
	<C> Name='�ǰ�����'			ID=BF_DEDUCT5			Width=60	</C>
	">
</OBJECT>	

<OBJECT id=gr4  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 60px;border:1 solid #777777;display:NONE;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds4">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<C> Name='���� ����û'		ID=GIVAMT_10A 	Width=60	</C>    
	<C> Name='���� �׹�'		ID=GIVAMT_10B	Width=60	</C>    
	<C> Name='��ġ ����û'		ID=GIVAMT_20A	Width=60	</C>    
	<C> Name='��ġ �׹�'		ID=GIVAMT_20B	Width=60	</C>    
	<C> Name='���� ����û'		ID=GIVAMT_40A	Width=60	</C>    
	<C> Name='���� �׹�'		ID=GIVAMT_40B 	Width=60	</C>    
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>



<TABLE cellSpacing=0 cellPadding=0 width=854 border=0>
  <TR>
    <TD vAlign=top width=1003 bgColor=#ffffff height=62>

	  <TABLE cellSpacing=0 cellPadding=0 width=1003 align=center border=0>
        <TR>
          <TD><IMG src="imgs/tit_01_14.gif"></TD>
		</TR>
	  </TABLE>
	  
	  
	  <BR>
	  <!--�������� -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=30 bgColor=#aad2ff rowSpan=4>����<BR>���� 
          <TD width=82>�����ȣ</TD>
          <TD width=160>�Ҽ�</TD>
          <TD width=140>����</TD>
          <TD width=106>�׷��Ի���</TD>
          <TD width=140>����</TD>
          <TD width=150>�ֹε�Ϲ�ȣ</TD>
          <TD>��ȭ��ȣ</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNO" style= "position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="DEPTCD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="PAYGRD" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="JOINDATE" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPNMK" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="000000-0000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

      	  <TD><%=HDConstant.COMMENT_START%>
			<object id="TELNUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
				<param name=Text 			value="">
				<param name=Alignment 		value=1>
				<param name=FORMAT 			value="00000000000000">
				<param name=Numeric			value="false">
				<param name=Border	 		value="false">		
				<param name=InheritColor    value="true">																																																				
				<param name=ReadOnly  		value="TRUE">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
        </TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD colSpan=4>�� ��</TD>
          <TD colSpan=3>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffffff>
          <TD colSpan=4><%=HDConstant.COMMENT_START%>
				<object id="ADDRESS" style= "position:relative;left:0px;top:2px;width:465px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD colSpan=3>&nbsp;</TD>
		</TR>
	  </TABLE>
		  
	
	<!-- �ٷμҵ� -->
	  <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        <TR align=CENTER>
          <TD width=30 bgColor=#aad2ff rowSpan=2>����</TD>
          <TD bgColor=#aad2ff colSpan=4>2006�� �ٷμҵ�</TD>
          <TD bgColor=#aad2ff colSpan=5>2006�� ��õ¡��</TD>
          <TD bgColor=#aad2ff>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#e8f3ff>
          <TD width=79>�����޿�</TD>
          <TD width=79>������</TD>
          <TD width=79>�����ҵ� ��</TD>
          <TD width=79>������ҵ� ��</TD>
          <TD width=79>���ټ�</TD>
          <TD width=79>�ֹμ�</TD>
          <TD width=79>���ο���</TD>
          <TD width=79>�ǰ�����</TD>
          <TD width=79>��뺸��</TD>
          <TD>&nbsp;</TD>
		</TR>
        <TR align=CENTER>
          <TD bgColor=#e8f3ff>�ݾ�</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff>&nbsp;</TD>
		</TR>
        <TR bgColor=#ffffff>
          <TD colSpan=14><!--
						&nbsp;&nbsp;�� ������� <br>
						&nbsp;&nbsp;&nbsp;&nbsp;�� �� �� �� �� : 2004�� ��������� �츮�������� �ҵ������ �޾Ҵ� �����
						2006�� ESOP�ֽ� �����Ͽ� �߻��� �ҵ��� &quot;�ٷμҵ�&quot;�� �ջ�˴ϴ�. <br>
						&nbsp;&nbsp;&nbsp;&nbsp;�� ������ҵ� : ���� - �ؿܱٹ��� �� 100����, �ڳຸ������ 10���� / �ؿ� - �ܱ����� ���� �� 150����,
						Ȳ�������� �� ��Ÿ ������ҵ� <br>-->
			&nbsp;&nbsp;<FONT color=#ff6633>�� �� �ݾ��� 12�� �޿� ���� �� ��ȸ�ڷ��̹Ƿ� 2006�� ���� Ȯ�� �ݾ��� �ƴմϴ�.</FONT> </TD>
		  </TR>
	  </TABLE><BR><BR>

	  <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD colSpan=6><B>I. ���س⵵ "����Ի��� �� �ٹ�ó�� 2�� �̻��� ���" ��(��)�ٹ��� �ҵ� �� ��õ¡�� ��Ȳ�� �Է¹ٶ��ϴ�.</B></TD></TR>
        <TR bgColor=#ffffff>
          <TD></TD>
          <TD width=25></TD>
          <TD></TD>
          <TD width=40></TD>
          <TD></TD>
          <TD width=470>&nbsp;</TD></TR></TABLE><!-- ���ٹ��� ��õ¡�� ��Ȳ -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR align=CENTER>
          <TD width=30 bgColor=#ffedd2 rowSpan=2>����</TD>
          <TD bgColor=#ffedd2 colSpan=2  onclick="openOfc();" style="cursor:hand"><b>ȸ���</b></TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_WKNM" style= "position:relative;left:0px;top:2px;width:265px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2 colSpan=2>����ڵ�Ϲ�ȣ</TD>
          <TD bgColor=#ffffff colSpan=2><%=HDConstant.COMMENT_START%>
				<object id="BF_RESINO" style= "position:relative;left:0px;top:2px;width:165px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">																																																				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffedd2>&nbsp;</TD></TR>
        <TR align=CENTER bgColor=#ffedd2>
          <TD align=CENTER>�����޿�</TD>
          <TD align=CENTER>������</TD>
          <TD align=CENTER>�����ҵ� ��</TD>
          <TD align=CENTER>������ҵ� ��</TD>
          <TD align=CENTER>�������ټ�</TD>
          <TD align=CENTER>�����ֹμ�</TD>
          <TD align=CENTER>���ο���</TD>
          <TD align=CENTER>�ǰ�����</TD>
          <TD align=CENTER>��뺸��</TD></TR>
        <TR align=left>
          <TD align=CENTER bgColor=#ffedd2>�ݾ�</TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_PAY" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_BNS" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_TAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_NTAX_SUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT1" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT2" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT3" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT4" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

          <TD bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="BF_DEDUCT5" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>

		</TR>
	  </TABLE>


	  <BR>
	  <BR>

	  <!-- �������� �� �����׸� -->
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800><B>��. ���� ���ΰ� �ξ簡���� �������� �� ���� �׸��� ����(��) �Ǵ� �Է¹ٶ��ϴ�.</B> 
          </TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD></TR>
        <TR>
          <TD width=800><FONT color=#3366ff>&nbsp;&nbsp;�� ���ǻ��� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� "���������ȳ�"�� �ݵ�� �����Ͻ� �� �Է¹ٶ��ϴ�. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� �Է� �� �����Ŀ��� �ݵ�� "����" ��ư�� �����ֽñ� �ٶ��ϴ�. 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#ff6633><B>��&nbsp;����û �ڷ�� : 
            ����û Ȩ���������� �����ϴ� ������������ �ݾ� 
            �Է�</B></FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;<B>��&nbsp;�׹��� �ڷ�� : ����û���� 
            �����ϴ� �������� �̿��� �� �Է�</B> </FONT></TD>
          <TD vAlign=bottom align=right colSpan=2><!-- <A 
            href="javascript:showDiv('write_guide',%20'../../images/Self/btn_guideclose.gif',%20'../../images/Self/btn_guideopen.gif');"><IMG 
            id=imgsrc src="imgs/btn_guideopen.gif" border=0></A> -->
        </TD></TR></TABLE>

      <DIV id=write_guide style="DISPLAY: none">
      <TABLE cellSpacing=1 cellPadding=3 width=1003 bgColor=#666666 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=12 bgColor=#ffedd2 
            rowSpan=30>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��<BR><BR>��</TD>
          <TD vAlign=top>
            <TABLE cellSpacing=0 cellPadding=2 width="100%" border=0>
              
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>1. �⺻����</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) �� �� : ���踦 �����ϴ�(�ֹε�ϵ�� ���Ű���) �ٷ���(����� ����)�� 
                  ��������(�����θ� ����), �ڳ�, �����ڸ�</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) ������ : �ٷ��� ������ �ֹε�ϵ�� ���������� �ݵ�� üũ�Ͽ��� 
                  <U><B>"�����ڱ� ����"</B></U>�� ��û�� �� ����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) �����ܱ��� : ����� �� �ξ簡���� �ܱ����� ��� "�ܱ��� ��"���� üũ�� �� 
                  <U><B>"�ܱ��ε�Ϲ�ȣ �Ǵ� ���ǹ�ȣ"</B></U>�� ������. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) �ֹε�Ϲ�ȣ : �Է��� ����⵵�� �ξ簡�� �⺻���� ���� ���ɰ� 
                  �߰�����(�ڳ������, ��ο��) ���� ���θ� �ڵ�üũ��. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �� �� �� : 
                  �������� ����. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �ξ簡�� : 
                  ��60�� �̻� ���� �������ӡ����� - 1946.12.31 ���� 
                  ��&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;��55�� �̻� ���� 
                  �������ӡ��ڸ� - 1951.12.31 ������ 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  ��20�� ���� �����ӡ������ڸ� - 1986.01.01 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� �ڳ���� : 
                  ��6�� ���� ������ - 2000.01.01 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px"><FONT color=#3366ff>�� ��ο�� : 
                  ��65��~69�� - 1941.12.31 
                  ������&nbsp;&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;&nbsp;��70�� �̻� - 
                  1936.12.31 ������ </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#ff6633>5) ���� �ҵ�ݾ� : <U><B>"�ξ簡�� 
                  ��������"</B></U>�� �����Ǵ� ���� ���� �Ѽҵ�ݾ�(��/�� + ������ + ���ڼҵ� + ����ҵ� �� 
                  �հ��)�� 
                  <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  "100��������(�ҵ���� ���� �� �ݾ�)"�� ��� �ݵ�� üũ�Ͽ��� ����� �� �ξ簡���� �⺻������ ���� �� 
                  ����. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ���� �Ѽҵ�ݾ� = ���� �����ҵ� - 
                  �ҵ����(�ʿ����� ����) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">&nbsp;&nbsp;&nbsp;&nbsp;��) 
                  �ٷμҵ�(��/��)�� �ִ� ��� �����ҵ��� <U><B>�� 700���� ����</B></U>�� ���� ���� �����ϳ�, 
                  100���� �̻��� �������� ���Ե� ���� ���� �Ұ�����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>2. �߰�����</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) �γ��� ���� : �ٷ��� ������ ������ ��쿡�� üũ�� �� ����. (���� �ٷ��ڴ� 
                  ���ö��� ��Ȱ��ȭ �Ǿ� üũ �Ұ�����.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ��ȥ������ ��� : �ֹε�ϵ�� �⺻������ ����޴� 
                  �ξ簡���� �ִ� �������̸� ���� ������. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� ��ȥ������ ��� : ȥ�νŰ� �� �γ����̸� ���� 
                  ������. (������ �ҵ����� �������.) </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) �ڳ������ : �������� ��6�� ������ ��쿡�� üũ�� �� ����. (��7�� 
                  �ʰ��ڴ� ���ö��� ��Ȱ��ȭ �Ǿ� üũ �Ұ�����.)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">�� �¹��� �κ��� ��� - �θ��� 1�θ� ���� ���� ���� 
                </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 200px">- �� �ڳ࿡ ���� ������ �⺻������ �ް� ����ڰ� 
                  �߰��� �ڳ����������� ���� �� ����. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) ����� ���� : ���������� ������, ���� �Ѽҵ�ݾ��� 100���� ������ ������� 
                  ��쿡�� �ش���� üũ�� �� ����.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 75px">(���� �ҵ�ݾ� 100���� ���� �� ���� üũ �� �� 
                  ��� ���ö��� ��Ȱ��ȭ�Ǿ� üũ �Ұ�����)</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=3><B>3. Ư������</B></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>�� ����û �ڷ� : ����û Ȩ���������� �����ϴ� 
                  �ڷ� (��ǥ�� �� - ���ݿ�����)</FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2><FONT color=#3366ff>&nbsp;&nbsp;&nbsp;&nbsp;�׹��� 
                  �ڷ� : ����û���� �����ϴ� �������� �̿��� �� (����ó�� �� �ش� ������� ��� �����ϴ� �ڷ�) 
                </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>1) ����� : ���� �� ���踦 �����ϴ� ������ "�Ǻ�����"�� �Ͽ� ���� �ٷ��ڰ� ���� 
                  ������ "�ҵ���� ������ ���强 ����� ���� �հ�� " ���� </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px"><FONT color=#ff6633>�� ����� �� 
                  �ξ簡���� �⺻���� ������(���ɡ��ҵ��� ������)���� �ش���� Ȱ��ȭ�Ǿ� �Է� ������. </FONT></TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">�� ��������뺸���� �Ǻ����ڰ� ���� �ҵ�ݾ� 100���� 
                  ������ ������̾�� �ϸ� �������� "����� ���� ���强 �����"��� ����Ǿ� �־�� ��.</TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>2) �Ƿ�� : ���� �� ���踦 �����ϴ� ������ ���Ͽ� ���� �ٷ��ڰ� ���� ������ ġ�� 
                  �� �������� �Ƿ�� ���� <U><B>(�����ݾ� = �ҵ���� ����)</B></U> </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD width=20>&nbsp;</TD>
                <TD style="PADDING-LEFT: 40px">�� �Ȱ� �� ����Ʈ���� ���Ժ���� 1�δ� 50���� 
                  �ѵ������� �Ƿ�� ����׿� ���Ե�. </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>3) ������ : ���� �� ���踦 �����ϴ� ������ ���Ͽ� ������ ������, ���б�, 
                  �������, ������ �Ƶ��� �п������� �� ���� </TD></TR>
              <TR>
                <TD width=10>&nbsp;</TD>
                <TD width=10>&nbsp;</TD>
                <TD colSpan=2>4) �ſ�ī�塤�п��� ���γ��Ρ����ݿ����� : ���� �� ���踦 �����ϴ� ����(�����ڸ� 
                  ����)�� ������ �ſ�ī�塤���ݿ����� ���� ���� �� �п��� ����� �� 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                  ���ܱ����� ���� ������ ���� �п��� ������ ���� �ݵ�� <U><B>"����(ZERO)����"</B></U>�� 
                  �̿��Ͽ� ������ �ݾ� ����</TD></TR></TABLE></TD></TR></TABLE></DIV>


<table width=1003>
	<tr>
		<td>&nbsp;</td>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">
			<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply3();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel3()">
		</nobr>&nbsp;</td>
	</tr>					
</table>

<!-- CheckBox���·� ǥ���� Column�� Interger�� ���  Check Data�� 1, 0�� ����ϸ�, String�� ��� Check Data�� ��T��, ��F���� ����Ѵ�-->
<%=HDConstant.COMMENT_START%>
<OBJECT id=gr3  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 1003px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds3">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick"   value="1">
	<param name=IndWidth" value="20">
	<Param Name="UsingOneClick"   value="1">	
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<G> name='�ٷμҵ���'	
		<C> Name='����'		ID=RELAT1	HeadAlign=Center align=center   Width=63  EditStyle=Combo
	 		Data='0:����,1:�ҵ�����,2:�������,3:�����,4:������,5:�����ڸ�,6:��Ÿ'</C>
		<C> Name='����'		ID=FAMNM1	HeadAlign=Center align=center   		Width=63	</C>
		<C> Name='�ܱ���'		ID=REF1	    HeadAlign=Center align=center   Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='�⺻����'
		<C> Name='�ֹι�ȣ'	ID=RESINO1   HeadAlign=Center align=center  Width=100 mask='XXXXXX-XXXXXXX'	</C>
		<C> Name='100��'	ID=REF2	 HeadAlign=Center align=center      	Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<G> name='�߰�����'		
		<C> Name='�����'		ID=REF3	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='�ڳ�'		ID=REF4	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='���'		ID=REF5	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
		<C> Name='�γ���'		ID=REF6	    HeadAlign=Center align=center   		Width=40	editlimit=16 EditStyle=CheckBox</C>
	</G>
	<X> name='Ư������'
		<G> name='�����'
			<C> Name='����û'		ID=REF11	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF21	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='�Ƿ��'		
			<C> Name='����û'		ID=REF12	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF22	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='������'
			<C> Name='����û'		ID=REF13	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REF23	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
		<G> name='ī��/����'		
			<C> Name='����û'		ID=REFc1	HeadAlign=Center align=right  Width=63	EDIT=none</C>
			<C> Name='�׿�'		ID=REFc2	HeadAlign=Center align=right  Width=63	EDIT=none</C>
		</G>			
	</X>			
	</G>		
	<C> Name='���'				ID=APPDT   		Width=63	show=false</C> 
	<C> Name='���'				ID=EMPNO  		Width=60	show=false</C> 
	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>



<br><br><br>
      
      
      
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        <TR bgColor=#ffffff>
          <TD><B>��. ���� ��Ÿ ���� �׸񿡴� <FONT color=#ff6633>"�ٷ��� ���� ����" </FONT>�� ������ �ݾ׸� �Է¹ٶ��ϴ�.</B> </TD>
		<td align="right"><br>
		<nobr>
			<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
			<!-- <img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow3()">-->
			<!-- <img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow3()">-->
			<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
			<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
		</nobr>&nbsp;</td>

        </TR>
      </TABLE>
            
            
      <TABLE cellSpacing=1 cellPadding=3 width=1003 align=center bgColor=#666666 
      border=0>
        
        <TR bgColor=#ffedd2>
          <TD align=CENTER rowSpan=19>��<BR>Ÿ<BR><BR>Ư<BR>��<BR><BR>��<BR>��</TD>
          <TD align=CENTER width=50>�� ��</TD>
          <TD align=CENTER colSpan=2>�� �� �� ��</TD>
          <TD align=CENTER width=130>�� �� �� ��</TD>
          <TD align=CENTER width=90>�� �� �� ��</TD>
          <TD align=CENTER>�� �� �� ��</TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=7>�����ڱ�</TD>
          <TD align=left width=110 bgColor=#ffffff rowSpan=3>&nbsp;���ø�������</TD>
          <TD align=left width=140 bgColor=#ffffff>&nbsp;�� û������</TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=3>�ٷ��� ���� ������ <BR>�� ���Ծ� 
            <BR>(40% ���� ������ �ݾ�)</TD>
          <TD align=CENTER bgColor=#ffffff ROWSPAN=3><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD bgColor=#ffffff rowSpan=3>&nbsp;* �ٷ��� ������ �������̸�, �������� �Ǵ� 1���� 
            ������(�������ñԸ�)�� <BR>&nbsp;&nbsp;&nbsp;&nbsp;��� �� ���Ծ� ���� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2006�� �ű� ������ø������� 
            ������<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ���Դ�� �����������μ� 
            ���ؽð��� 3��� ������ ���ü����ڿ��� ��.<BR></FONT></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� �ٷ������ø�������</TD>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ������ø�������</TD>
        <TR>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;�����������Ա� (�� ���� ���� 
          ���Ա�)</TD>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� �����ݻ�ȯ��<BR>(40%���� 
            ������ݾ�)</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT02" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* �� ���ø������࿡ ������ �ڰ� �������ñԸ� 
            ������ ������ �����ϱ�<BR>&nbsp;&nbsp;&nbsp;&nbsp;���� 1996.1.1 ���� <U><B>"����� 
            ����"</U></B>�Ͽ� ������ ��� �� �����ݻ�ȯ<BR>&nbsp;&nbsp;&nbsp;&nbsp;���� </TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;�������<BR>&nbsp;�������Ա� 
          </TD>
          <TD align=left bgColor=#ffffff>&nbsp;�� ��ȯ�Ⱓ 14�� �̸� </TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>�ٷ��� ���θ�����<BR>&nbsp;�� 
          ���ڻ�ȯ��</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=3>&nbsp;* �ٷ��� ������ �������̸�, 
            �������ñԸ��� ����(�о�ǡ����ֱ� 3���<BR>&nbsp;&nbsp;&nbsp;&nbsp;����)�� ����ϱ� ���Ͽ� ���ÿ� 
            ������� �����ϰ� ������ ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ���ڻ�ȯ�� ���� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 2006�� �ű� 
            �����������������<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: ���� ��� 
            �о��/���ֱ� �򰡾��� 3��� ���Ͽ��� ��.</FONT> </TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff>&nbsp;�� ��ȯ�Ⱓ 15�� �̻� </TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="HOUAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>�����ڱ� ��</TD>
          <TD align=CENTER bgColor=#fff8ee>
			<%=HDConstant.COMMENT_START%>
			<object id="HOUSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=7  onclick="openGibu();" style="cursor:hand"><b>��α�</b></TD>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;���װ�����α�</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>�ٷ��� ���θ�����<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=7>&nbsp;* 
            ������ݡ������ǿ��ݡ�����/�縳�б��� �ü��� � ����� ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ξ� 
            ���� <BR><BR>&nbsp;* ����(�Ŀ�ȸ �� ���Ű�������ȸ ����)�� ����� �� ��ġ�ڱ� ���� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;<FONT color=#3366ff>�� 10���� ���� �ݾ��� ���װ��� + 10���� �ʰ� �ݾ��� �ҵ���� </FONT><BR><BR>&nbsp;* ��������ȭ����������������ȸ���������ڼ���ü �� 
            ���ͼ���ü�� ����� ��� <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ξ� ���� <BR><BR></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_10B" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff rowSpan=2>&nbsp;��ġ�ڱ� ��α�</TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>�ٷ��� ���θ�����<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_20A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_20A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=left bgColor=#ffffff 
            rowSpan=2>&nbsp;�ٷμҵ�<BR>&nbsp;10%�ѵ���α�<BR>&nbsp;(������ü ��� ��) </TD>
          <TD align=CENTER bgColor=#fff8ee><FONT color=#ff6633>����û�ڷ�</FONT></TD>
          <TD align=CENTER bgColor=#ffffff rowSpan=2>�ٷ��� ���θ�����<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee>�׹����ڷ�</TD>
          <TD align=CENTER bgColor=#ffffff><%=HDConstant.COMMENT_START%>
			<object id="GIVAMT_40A" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee colSpan=3>��α� ��</TD>
          <TD align=CENTER bgColor=#fff8ee><%=HDConstant.COMMENT_START%>
			<object id="CONSUM" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>���ο���</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2000�� ���� ������ ����</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ�� ��ü ���� ����<BR>(2000�� ���� �Ի���)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ���ϰ�ó��</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#3366ff>&nbsp;* ȸ�翡�� ��ü ������ ���ѻ��� ���ο��� ���Ծ��� ������ ���� �Է����� 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;����. <BR>&nbsp;&nbsp;&nbsp;&nbsp;�� ��ü ���� ��ǰ�� : ��������55(60)�� ����, ���̵帲 10�ⳳ, 
            <BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ����������55��</FONT> </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���Ծ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT011" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
            </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#fff8ee rowSpan=2>��������</TD>
          <TD align=left bgColor=#ffffff colSpan=2 rowSpan=2>&nbsp;2001�� ���� ������ ����</TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ�� ��ü ���� ����<BR>(2001�� ���� �Ի���)</FONT></TD>
          <TD align=CENTER bgColor=#ffffff><FONT color=#3366ff>ȸ���ϰ�ó��</FONT></TD>
          <TD class=tit_f10 bgColor=#ffffff rowSpan=2><FONT color=#3366ff>&nbsp;* ȸ�翡�� ��ü ������ ���� ����������Ծ��� ������ ���� �Է����� ����. <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;�� ��ü ���� ��ǰ�� : Ʈ���ÿ���, ū������� </FONT>
		  </TD>
		</TR>
        <TR>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���Ծ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="ETCAMT01" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD></TR>
        <TR>
          <TD align=CENTER bgColor=#ffedd2 rowSpan=2>��<BR>��<BR>��<BR>��</TD>
          <TD align=CENTER bgColor=#fff8ee >��ġ�ڱ�</TD>
          <TD align=left bgColor=#ffffff COLSPAN=2>&nbsp;��ġ�ڱ� ��α�</TD>
          <TD align=CENTER bgColor=#ffffff >�ٷ��� ���� ������<BR>�� ��αݾ�</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT04" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="TRUE">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%></TD>
          <TD class=tit_f10 bgColor=#ffffff><FONT 
            color=#3366ff>&nbsp;* ����(�Ŀ�ȸ �� ���Ű�������ȸ ����) ��ξ��� 10���������� 
            ���<BR>&nbsp;&nbsp;&nbsp;&nbsp;���Ͼ� ���� (�ڵ��Է�)</FONT> </TD></TR>

        <TR>
          <TD align=CENTER bgColor=#fff8ee>�����ڱ�</TD>
          <TD align=left bgColor=#ffffff colSpan=2>&nbsp;�̺о�����������Ա� ��ȯ����</TD>
          <TD align=CENTER bgColor=#ffffff>�ٷ��� ���θ�����<BR>�� ���ڻ�ȯ��</TD>
          <TD align=CENTER bgColor=#ffffff>
			<%=HDConstant.COMMENT_START%>
			<object id="DEDAMT03" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input01">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">																																																				
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
			</object>
			<%=HDConstant.COMMENT_END%>
		  </TD>
          <TD class=tit_f10 bgColor=#ffffff>&nbsp;* �������� �ٷ��� ���� ���Ƿ� "1995.11.1~1997.12.31" �� ����� �̿��� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;������ �������ñԸ� ������ �̺о� ������ ����ϱ� ���� �������ñ�� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;�Ǵ� �����������κ��� 1995.11.1 ���� ������ ���Աݿ� ���� �� ���� <BR>
			&nbsp;&nbsp;&nbsp;&nbsp;��ȯ�� ����</TD>
		  </TR>
	  </TABLE>
	  <BR>
      <TABLE cellSpacing=1 cellPadding=3 width=1003 border=0>
        
        <TR bgColor=#ffffff>
          <TD width=800>&nbsp;</TD>
          <TD vAlign=bottom align=right></TD>
          <TD vAlign=bottom align=right></TD>
		</TR>
	  </TABLE>

	  <!--���ݺ����-->
	  <INPUT type=hidden value=1,486,800 name=pybsgm>
	  <INPUT type=hidden value=0 name=pybsto> 
	  
	  <!--�����-->
	  <INPUT type=hidden value=802,130 name=pybsbh> 
	  <INPUT type=hidden value=173,047 name=pybsgy> 
	  <INPUT type=hidden value=0 name=pybins> 
	  <INPUT type=hidden value=0 name=pybin2> 
	  <INPUT type=hidden value=0 name=pybito> 
	  
	  <!--�Ƿ��-->
	  <INPUT type=hidden value=0 name=pybmsd> 
	  <INPUT type=hidden value=0 name=pybmgd> 
	  <INPUT type=hidden value=0 name=pybmtc> 
	  <INPUT type=hidden value=0 name=pybmto> 
	  <INPUT type=hidden value=0 name=pybmtm> 
	  
	  <!--������-->
	  <INPUT type=hidden value=0 name=pybsed> 
	  <INPUT type=hidden value=0 name=pybebc> 
	  <INPUT type=hidden value=0 name=pybebt> 
	  <INPUT type=hidden value=0 name=pybecc> 
	  <INPUT type=hidden value=0 name=pybect> 
      <INPUT type=hidden value=0 name=pybedc> 
	  <INPUT type=hidden value=0 name=pybedt> 
	  <INPUT type=hidden value=0 name=pybetc> 
	  <INPUT type=hidden value=0 name=pybets> 
	  <INPUT type=hidden value=0 name=pybeto> 

      <!--ī���-->
	  <INPUT type=hidden value=0 name=pybcad> 
	  <INPUT type=hidden value=0 name=pybhnd> 
	  <INPUT type=hidden value=0 name=pybsgd> 
	  <!--<input type="hidden" name="pybmex" value="0">-->
	  <INPUT type=hidden value=0 name=pybcto> 

      <DIV id=tipbox style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BACKGROUND: infobackground; LEFT: 0px; VISIBILITY: hidden; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; POSITION: absolute; TOP: 0px"></DIV>
	</TD>
  </TR>
</TABLE>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNO  	  	Ctrl=EMPNO  	   	Param=text</C>
		<C>Col=DEPTCD  	  	Ctrl=DEPTCD  	   	Param=text</C>
		<C>Col=PAYGRD  	  	Ctrl=PAYGRD  	   	Param=text</C>
		<C>Col=JOINDATE   	Ctrl=JOINDATE      	Param=text</C>
		<C>Col=EMPNMK  	  	Ctrl=EMPNMK  	   	Param=text</C>
		<C>Col=EMPJUNO    	Ctrl=EMPJUNO       	Param=text</C>
		<C>Col=TELNUM    	Ctrl=TELNUM       	Param=text</C>
		<C>Col=ADDRESS    	Ctrl=ADDRESS       	Param=text</C>
		<C>Col=TAX_PAY    	Ctrl=TAX_PAY       	Param=text</C>
		<C>Col=TAX_BNS    	Ctrl=TAX_BNS       	Param=text</C>
		<C>Col=TAX_SUM    	Ctrl=TAX_SUM       	Param=text</C>
		<C>Col=NTAX_SUM   	Ctrl=NTAX_SUM      	Param=text</C>
		<C>Col=DEDUCT1 	  	Ctrl=DEDUCT1 	   	Param=text</C>
		<C>Col=DEDUCT2 	  	Ctrl=DEDUCT2 	   	Param=text</C>
		<C>Col=DEDUCT3 	  	Ctrl=DEDUCT3 	   	Param=text</C>
		<C>Col=DEDUCT4 	  	Ctrl=DEDUCT4 	   	Param=text</C>
		<C>Col=DEDUCT5    	Ctrl=DEDUCT5       	Param=text</C>

		<C>Col=HOUAMT01   	Ctrl=HOUAMT01         	Param=text</C>	
		<C>Col=HOUAMT02   	Ctrl=HOUAMT02         	Param=text</C>
		<C>Col=HOUAMT03   	Ctrl=HOUAMT03         	Param=text</C>
		<C>Col=HOUAMT04   	Ctrl=HOUAMT04         	Param=text</C>
		<C>Col=HOUSUM 	  	Ctrl=HOUSUM 	      	Param=text</C>
		<C>Col=ETCAMT011  	Ctrl=ETCAMT011        	Param=text</C>
		<C>Col=ETCAMT01   	Ctrl=ETCAMT01         	Param=text</C>
		<C>Col=CONSUM   	Ctrl=CONSUM         	Param=text</C>
		<C>Col=DEDAMT03   	Ctrl=DEDAMT03         	Param=text</C>
		<C>Col=DEDAMT04   	Ctrl=DEDAMT04         	Param=text</C>		
	'>
</object>

<object id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds2>
	<param name=BindInfo  value='
		<C>Col=BF_WKNM     	  	Ctrl=BF_WKNM     	   	Param=text</C>
		<C>Col=BF_RESINO	  	Ctrl=BF_RESINO	       	Param=text</C>
		<C>Col=BF_TAX_PAY	  	Ctrl=BF_TAX_PAY	       	Param=text</C>
		<C>Col=BF_TAX_BNS	  	Ctrl=BF_TAX_BNS	       	Param=text</C>
		<C>Col=BF_TAX_SUM 	  	Ctrl=BF_TAX_SUM 	   	Param=text</C>
		<C>Col=BF_NTAX_SUM 	  	Ctrl=BF_NTAX_SUM 	   	Param=text</C>
		<C>Col=BF_DEDUCT1     	Ctrl=BF_DEDUCT1        	Param=text</C>
		<C>Col=BF_DEDUCT2	  	Ctrl=BF_DEDUCT2	       	Param=text</C>
		<C>Col=BF_DEDUCT3	  	Ctrl=BF_DEDUCT3	       	Param=text</C>
		<C>Col=BF_DEDUCT4	  	Ctrl=BF_DEDUCT4	       	Param=text</C>
		<C>Col=BF_DEDUCT5	  	Ctrl=BF_DEDUCT5	       	Param=text</C>
	'>
</object>

<object id=gcbn_data4 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds4>
	<param name=BindInfo  value='
		<C>Col=GIVAMT_10A  	Ctrl=GIVAMT_10A 	   	Param=text</C>
		<C>Col=GIVAMT_10B  	Ctrl=GIVAMT_10B       	Param=text</C>
		<C>Col=GIVAMT_20A  	Ctrl=GIVAMT_20A       	Param=text</C>
		<C>Col=GIVAMT_20B  	Ctrl=GIVAMT_20B       	Param=text</C>
		<C>Col=GIVAMT_40A  	Ctrl=GIVAMT_40A	  		Param=text</C>
		<C>Col=GIVAMT_40B  	Ctrl=GIVAMT_40B 	   	Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>




</FORM>
</BODY>
</HTML>
