<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_card1
 * J  S  P		: P030009i
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������	: 
 *                   
 * ������������ 	: 2011-01-04
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");				//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
    String eJuno 		 = request.getParameter("eJuno");			//������� �ֹι�ȣ
%>

<html>
<head>
<title><%=eyy%> �� �ٷμҵ���� �ſ�ī��/����ī��/���ݿ����� ���� �� �Է�</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
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
<SCRIPT language="JavaScript" src="imgs/ApplyChk.js"></SCRIPT>
<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
	var gstrChk =""; //���
	var gs_level;
	var gs_treecd;
	
	get_cookdata();
	
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
	function ln_Start(){
		//�׸��� ��Ÿ�� �ֱ�
		cfStyleGrid(getObjectFirst("gr1"), "comn");
	
		fnSelect("<%=eyy%>", "<%=eno%>", "<%=eJuno%>");	//�⺻���� ��ȸ
	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno, pJuno) {	 //������ : �Ķ���� �޾Ƽ� �⺻ ��ȸ

			v_job = "S";	//select �ϵ�..

			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno 
			          + ",eJuno="     + pJuno ;

			//alert("������!");

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030010i_05",			//��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);
	
			tr_post(tr1);
					

	}
	

	
/******************************************************************************
	Description : ����
******************************************************************************/
	function fnDeleteRow() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	
/******************************************************************************
	Description : ����
******************************************************************************/
    function fnApply() {// ���� �����ͼ� �ݿ�

	   // if(!Card_Apply_Chk("ds1")) return;
		
        if (ds1.IsUpdated) {
			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			}
            
            v_job = "I";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           

            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030010i_05",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);

            tr_post(tr1);
        } else {
            alert("�ſ�ī�� / ���ݿ����� �� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnSaveChk(){ //������ �������ⱸ��üũ
		v_job = "S";	  //select �ϵ�..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
        
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030010i",	//		��� ������ ��!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}
	
/******************************************************************************
	Description : ���
******************************************************************************/
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 
	
	function fnClose()	{
		window.close();
		opener.fnSelect3("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
//		opener.ds3.reset();
	};

/******************************************************************************
	Description :�հ� ���
******************************************************************************/
function calTotal(gbn) {
	if (gbn=='1')	{
		getObjectFirst("f_CARDTOT1").text= parseInt(getObjectFirst("f_CARD11").text) + parseInt(getObjectFirst("f_CARD21").text);
	} else if (gbn=='2') {
		getObjectFirst("f_CARDTOT2").text= parseInt(getObjectFirst("f_CARD12").text) + parseInt(getObjectFirst("f_CARD22").text);
	} else if (gbn=='3') {
		getObjectFirst("f_CARDTOT3").text= parseInt(getObjectFirst("f_CARD13").text) ;
	} else if (gbn=='4') {
		getObjectFirst("f_CARDTOT4").text= parseInt(getObjectFirst("f_CARD14").text) + parseInt(getObjectFirst("f_CARD24").text);
	};
	
}	;
</script>




<script language="javascript" for="tr1" event="onsuccess()">

    if(v_job=="I") {	//����
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();
    }  else if(v_job == "H" || v_job=="S") {
        window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		calTotal('1');
		calTotal('2');
		calTotal('3');		
		calTotal('4');		
    }

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


<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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






<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<form name="entry" method="post" action="">
   <br>
   <b><font face="����">&nbsp;�� �ſ�ī�� �� ���� �ҵ����</a></font></b>
   <br><font color="#7800BF" size="2" face="����"> 
      &nbsp;�� �ٷμҵ��� �Ǵ� ���ҵ� 100���� ������ �����, �ξ簡���� ���ؿ��� 1�� ~ 12������ ����� �ݾ׿� ���� �����ϴ� ���Դϴ�.</font>
	<!-- �������� �� �����׸� -->
	<table width="820" border="0" cellspacing="0" cellpadding="0">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
			 <table width="820" border="0" cellspacing="1" cellpadding="3" height="181" bgcolor="#666666" align="center">
			  <tr bgcolor="#FFF8EE">
				<td bgcolor="#FFF8EE" width="80">
				  <div align="center"><font face="����">�� ��</font></div>
				 </td>
				<td width="520">
				  <div align="center"><font face="����">�� &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��</font></div>
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
					  <div align="center"><font face="����">���Ⱓ</font></div>
					</td>
				  <td><font face="����">���س⵵ 1�� ~ 12�� ���� </font></td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
				    <div align="center"><font face="����">�ҵ������<br> ��� </font></div>
				  </td>
				  <td bgcolor="#FFFFFF">
                  �� A+B<br>
				  A : (�ſ�ī��� ���ݾ� - �ѱ޿���X25%) X ����ī��� ����/�ſ�ī��� ���ݾ� X 25%<br>
				  B : (�ſ�ī��� ���ݾ� - �ѱ޿���X25%) X ����ī��� ���� ����/�ſ�ī��� ���ݾ� X 20%<br>
				  ���ѱ޿��� 20% <br>
				  ��300���� </td>
				   </td>
				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="����">�����ѵ�</font></div>
				  </td>
				  <td><font face="����">Min(��, ��, �� )</font>

				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="����">�������ݾ� </font></div>
				  </td>
				  <td>����,�����,�ξ簡���� ����� �ݾ�(����) <br>
					- �ſ�ī��, ����ī��, ���ļ���ī��, �����������޼���, ��ȭ��ī�� ��<br>
					- ���γ��� �п� ������<br>
					- ���ݿ����� ���ݾ�
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">

				<td bgcolor="#FFF8EE">
				  <div align="center"><font face="����">�������ܾ� </font></div>
				  </td>
				  <td>
					- ����� �� ȸ�� �������<br>
					- ���������(���ݺ����,�ǷẸ���), ����������(������,���б�,�������)<br>
					- ����,���漼,�����,������ �� / ���� ��� �ݾ� /�����ڸ��� ���ݾ�<br>
                    - �¹��̺κ��� ���� ����ڰ� ����� �ݾ�
					<!-- - �ּ����� �ٸ� 20�� �ʰ� �ڳ��� ���ݾ� �� -->
				  </td>
				</tr>
				<tr bgcolor="#FFFFFF">
				  <td bgcolor="#FFF8EE">
					<div align="center"><font face="����">���⼭�� </font></div>
				  </td>
				  <td ><font face="����">�ſ�ī��ҵ������û��,�ſ�ī����ݾ�Ȯ�μ�, ���ݿ����� ���ݾ� Ȯ�μ� </font></td>
				</tr>
			  </table>
			</td>
		</tr>
		<tr bgcolor="#FFFFFF">
	       <td  height="20">
            <font color="#7800BF" face="����">�� ���ݿ����� ���ݾ� Ȯ�μ��� ����û ���ݿ����� Ȩ������(<a href="http://www.taxsave.go.kr" target="_blank">www.taxsave.go.kr</a>)���� ȸ������ �� ������ ���� �߱� ����.</font>
		</tr>
		<tr>
			<td align="right"><br>
			<nobr>
				<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
				<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
				&nbsp;&nbsp;<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">						
			</nobr>&nbsp;</td>
		</tr>
	</table>	

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 636px; HEIGHT: 100px;border:1 solid #777777;display:none;" viewastext>
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

	<C> Name='���'						ID=EMPNO  			Width=60	</C> 
	<C> Name='����'						ID=EMPNMK  		Width=40	</C> 
	<C> Name='�ֹι�ȣ'				ID=EMPJUNO  		Width=60	</C> 	
	<C> Name='�ξ簡������1'		ID=FAMNMK			Width=64	</C>
	<C> Name='�ξ簡������1'		ID=FAMRELA_NM	Width=65	</C>
	<C> Name='�����ڵ�'				ID=FAMRELA_CD	Width=35	</C>	
	<C> Name='�����ֹι�ȣ1'		ID=FAMJUNO		Width=55	</C>

	<C> Name='�ܱ���YN'				ID=REF1   			Width=40	</C>
	<C> Name='100��������YN'		ID=REF2   			Width=40	</C>
	<C> Name='�����YN'				ID=REF3   			Width=40	</C>
	<C> Name='�ڳ�YN'					ID=REF4   			Width=40	</C>
	<C> Name='���YN'					ID=REF5   			Width=40	</C>

	<C> Name='����ûī��' 			ID=CARD11			Width=50	</C>
	<C> Name='����û����' 			ID=CARD12			Width=50	</C>
	<C> Name='����û����' 			ID=CARD13			Width=50	</C>
	<C> Name='����û�п�' 			ID=CARD14			Width=50	</C>
	<C> Name='����û��ī��' 			ID=CARD21			Width=50	</C>
	<C> Name='����û������' 			ID=CARD22			Width=50	</C>
	<C> Name='����û���п�' 			ID=CARD24			Width=50	</C>
	<C> Name='���'						ID=APPDT   			Width=63	</C> 
	
	<C> Name='Flag'	    				ID=FLAGCOL			Width=20	</C>	

	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

	<table width="820" bgcolor="#666666" border="0" cellspacing="1" cellpadding="3">
		<tr align="center" bgcolor="#FFFFFF">
			<td colspan="2" bgcolor="#ffedd2">�� �� �� �� ��</td>
			<td colspan="3" bgcolor="#ffedd2">�� �� �� û �� (= �� �� ��)</td>
			<td colspan="5" bgcolor="#ffedd2">�� ��</td>
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee" width="55" >�� ��</td>
			<td bgcolor="#fff8ee" width="90" >�ֹε�Ϲ�ȣ</td>
			<td bgcolor="#fff8ee" width="55" >�� ��</td>
			<td bgcolor="#fff8ee" width="70" >�� ��</td>
			<td bgcolor="#fff8ee" width="90" >�ֹε�Ϲ�ȣ</td>
			<td bgcolor="#fff8ee" width="65" >�ڷ� ����</td>
			<td bgcolor="#fff8ee" width="75" >�ſ�ī��</td>
			<td bgcolor="#fff8ee" width="75" >����ī�� ��</td>
			<td bgcolor="#fff8ee" width="75" >���ݿ�����</td>
			<td bgcolor="#fff8ee" width="75" >�п���<BR>���γ���</td>
		</tr>

	    <tr align="center" bgcolor="#FFFFFF">
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPNMK" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">										
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_EMPJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=FORMAT 			value="000000-0000000">
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">	
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMNMK" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 			value="">
					<param name=Alignment 		value=1>
					<param name=Numeric			value="false">
					<param name=Border	 		value="false">		
					<param name=InheritColor    value="true">				
					<param name=ReadOnly  		value="TRUE">
				</object>
				<%=HDConstant.COMMENT_END%>	
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMRELA_CD" style= "DISPLAY:NONE;position:relative;left:0px;top:2px;width:80px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">				
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<object id="f_FAMRELA_NM" style= "position:relative;left:0px;top:2px;width:55px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">			
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>			
			</td>
			<td rowspan="2">
				<%=HDConstant.COMMENT_START%>
				<object id="f_FAMJUNO" style= "position:relative;left:0px;top:2px;width:85px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F class="input00">
					<param name=Text 		value="0">
					<param name=Alignment 	value=1>
					<param name=Numeric		value="false">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=FORMAT 			value="000000-0000000">
					<param name=ReadOnly  		value="TRUE">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
				<input type="hidden" name="f_REF1" id="f_REF1" value="">
				<input type="hidden" name="f_REF2" id="f_REF2" value="">
				<input type="hidden" name="f_REF3" id="f_REF3" value="">
				<input type="hidden" name="f_REF4" id="f_REF4" value="">
				<input type="hidden" name="f_REF5" id="f_REF5" value="">
			</td>
			<td bgcolor="#fff8ee"><font color="#FF6633">����û�ڷ�</font></td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD11" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD12" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">		
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD13" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('3');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD14" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			
		</tr>
		<tr align="center" bgcolor="#FFFFFF">
			<td bgcolor="#fff8ee">�׹����ڷ�</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD21" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('1');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD22" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('2');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>

			<td>
				-
			</td>

			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARD24" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input01" onKeyup="calTotal('4');" >
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="false">
					<param name=SelectAll  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
		<tr align="center" bgcolor="#fff8ee">
			<td colspan="6">�� ��	</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT1" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT2" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT3" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
			<td><%=HDConstant.COMMENT_START%>
				<object id="f_CARDTOT4" style= "position:relative;left:0px;top:2px;width:70px;" classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 class="input02">
					<param name=Text 		value="0">
					<param name=Alignment 	value=2>
					<param name=Numeric		value="true">
					<param name=Border	 	value="false">		
					<param name=InheritColor      value="true">	
					<param name=ReadOnly  	value="true">
				</object>
				<%=HDConstant.COMMENT_END%>
			</td>
		</tr>
	</table>
</form>

<%=HDConstant.COMMENT_START%>
<object id=gcbn_data classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='
		<C>Col=EMPNMK 		Ctrl=f_EMPNMK  			Param=text</C>
		<C>Col=EMPNO  			Ctrl=f_EMPNO   			Param=text</C>		
		<C>Col=EMPJUNO		Ctrl=f_EMPJUNO 			Param=text</C>
		<C>Col=APPDT  			Ctrl=f_APPDT   				Param=text</C>

		<C>Col=FAMRELA_NM	Ctrl=f_FAMRELA_NM 	Param=text</C>
		<C>Col=FAMRELA_CD	Ctrl=f_FAMRELA_CD	 	Param=text</C>		
		<C>Col=FAMNMK 		Ctrl=f_FAMNMK  			Param=text</C>
		<C>Col=FAMJUNO		Ctrl=f_FAMJUNO 			Param=text</C>

		<C>Col=REF1   			Ctrl=f_REF1    				Param=value</C>
		<C>Col=REF2   			Ctrl=f_REF2    				Param=value</C>
		<C>Col=REF3   			Ctrl=f_REF3    				Param=value</C>
		<C>Col=REF4   			Ctrl=f_REF4    				Param=value</C>
		<C>Col=REF5   			Ctrl=f_REF5    				Param=value</C>

		<C>Col=CARD11 			Ctrl=f_CARD11  			Param=text</C>
		<C>Col=CARD12 			Ctrl=f_CARD12  			Param=text</C>
		<C>Col=CARD13 			Ctrl=f_CARD13  			Param=text</C>
		<C>Col=CARD14 			Ctrl=f_CARD14  			Param=text</C>
		<C>Col=CARD21 			Ctrl=f_CARD21  			Param=text</C>
		<C>Col=CARD22 			Ctrl=f_CARD22  			Param=text</C>
		<C>Col=CARD24 			Ctrl=f_CARD24  			Param=text</C>
	'>
</object>
<%=HDConstant.COMMENT_END%>


</body>
</html>
