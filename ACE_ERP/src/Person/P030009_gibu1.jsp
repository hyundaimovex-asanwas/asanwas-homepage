<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�	: �޿��ý���
 * ���α׷�ID 	: P030009_gibu1
 * J  S  P		: P030009_03i,P030009_03s
 * �� �� ��		: p030009i_06,p030009_s1 (�߰�)
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-01-11
 * �������	: 
 * �� �� �� : ���ϳ�                  
 * ������������ 	: 2009-01-07
 *****************************************************************************/
%>

<%@ page import="sales.common.*"%>

<%
	String eyy 		 = request.getParameter("eyy");			//�ͼӳ⵵
    String eno 		 = request.getParameter("eno");				//���
//    String eGivcod	 = request.getParameter("eGIVCOD");		//������� �̸�
    String eGivtype  = "";
%>

<html>
<head>
<title><%=eyy%> �� �ٷμҵ���� ��α� �� �Է�</title>
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

	//var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
	//var gs_date2 = gcurdate.substr(0,4) + gcurdate.substr(5,2);

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
	function ln_Start(){
		//�׸��� ��Ÿ�� �ֱ�
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ
		
		ln_Query();//�������� ��ȸ
	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
	function fnSelect(pYear, pEmpno, pGivcod) {	 //������ : �Ķ���� �޾Ƽ� �⺻ ��ȸ
			v_job = "S";	//select �ϵ�..
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",eyy="       + pYear
			          + ",eno="       + pEmpno ;
//			          + ",eGIVCOD="     + pGivcod;

			ln_TRSetting(tr1, 
			    "/services/servlet/Payroll.p030009i_06",	//		��� ������ ��!
			    "JSP(O:DS1=ds1)",
			    param);

			tr_post(tr1);
	}
	

/******************************************************************************
	Description : ����� ��ȸ
******************************************************************************/

	function ln_Query(){
	gcds_ds2.DataID = "/services/servlet/Payroll.p030009_s1?"
									 + "v_str1=" + <%=eno%>
								 	 + "&v_str2="+ <%=eyy%>;
	//prompt('',gcds_ds2.DataID);
	gcds_ds2.Reset();
}


/******************************************************************************
	Description : �߰�, ����, ����, ���
******************************************************************************/
	function fnAddRow(){
		ds1.AddRow();		//�����ͼ� ��� ������ �ȵǼ� �׳��ϸ� �ȵǾ���..
							// ó�� ��ȸ�Ҷ� ��������� �޾ƿ´�. ������ ����ȸ�� �Ѵ�..
		ds1.namevalue(ds1.RowPosition, "APPDT") = ds1.namevalue(1, "APPDT");
		ds1.namevalue(ds1.RowPosition, "EMPNMK") = ds1.namevalue(1, "EMPNMK");
		ds1.namevalue(ds1.RowPosition, "EMPJUNO") = ds1.namevalue(1, "EMPJUNO");
		ds1.namevalue(ds1.RowPosition, "GIVCOD") = ds1.namevalue(1, "GIVCOD");		
		ds1.namevalue(ds1.RowPosition, "GIVYEAR") = ds1.namevalue(1, "GIVYEAR");
		ds1.namevalue(ds1.RowPosition, "GIVMONTH") = ds1.namevalue(1, "GIVMONTH");
		ds1.namevalue(ds1.RowPosition, "GIVPRCD") = ds1.namevalue(1, "GIVPRCD");
		ds1.namevalue(ds1.RowPosition, "GIVPRNM") = ds1.namevalue(1, "GIVPRNM");
		ds1.namevalue(ds1.RowPosition, "GIVPRNO") = ds1.namevalue(1, "GIVPRNO");		
		ds1.namevalue(ds1.RowPosition, "EMPNO") = ds1.namevalue(1, "EMPNO");
	}
	
	function fnDeleteRow() {//Row ����
		/*if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        	alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        	ds1.undo(ds1.rowposition);
        	return;
        }*/
		ds1.DeleteRow(ds1.RowPosition);
	}
	
    function fnApply() {// ���� �����ͼ� �ݿ�
	    if(!Gibu_Apply_Chk("ds1")) return;
        if (ds1.IsUpdated) {
			if(!fnSaveChk()){
				alert("���� ������ �̹� �Ǿ����ϴ�. �������� ������ ���� �����ڿ��� �����Ͻʽÿ�.");
				return;
			};

			v_job = "I";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"           
            ln_TRSetting(tr1, 
                "/services/servlet/Payroll.p030009i_06",
                "JSP(I:DS1=ds1,O:RESULT=ds_result)",			//������ DS1, RESULT ���� java ������ req.getGauceDataSetKeys() ���� �ҷ���.
                param);
								prompt('',ds1.text);
            tr_post(tr1);
        } else {
            alert("��α� �� ������ ���� ������ �����ϴ�.");
        }
    }
    
	function fnCancel() {	//��ҽ� undo all. 
		ds1.undoall();
	} 

	
	function fnClose()	{
		window.close();
		opener.fnSelect4("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (��������)
		opener.fnSelect("<%=eyy%>", "<%=eno%>");	//�⺻���� ��ȸ (�⺻����)fnSelect
	};
	
	function fnSaveChk(){ //������ �������ⱸ��üũ
		v_job = "S";	  //select �ϵ�..
		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				  + ",eyy="       + <%=eyy%>
				  + ",eno="       + <%=eno%> ;
		ln_TRSetting(tr1, 
			"/services/servlet/Payroll.p030009i",	//		��� ������ ��!
			"JSP(O:DS9=ds9)",
			param);
		tr_post(tr1);

		if(ds9.namevalue(ds9.rowposition,"SENDFLAG")=="Y"){
			return false;
		}else{
            return true;
	    }
	}
</script>

<script language="javascript" for="tr1" event="onsuccess()">   
	if(ds1.countrow > 0) {
//		getObjectFirst("dspImg").style.display="none";
	} else {
//		getObjectFirst("dspImg").style.display="";
	}
    if(v_job=="I") {	//����
	    gf_msg();
        window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
		fnClose();
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

<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="true">
</object>


<comment id="__NSID__"><object id="gcds_ds1" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="true">
		<param name=UseChangeInfo    value=true>
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object id="gcds_ds2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT > 
    <PARAM NAME="SYNCLOAD" VALUE="true">
		<param name=UseChangeInfo    value=true>
</object></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gr1 event=OnCloseUp(row,colid)>

if(ds1.namevalue(row,"GIVCOD")== '20' ){
		ds1.namevalue(row,"GIVPRCD") = '1' ;

		alert(ds1.namevalue(row,"EMPNMK"));
		alert(ds1.namevalue(row,"GIVPRNM"));	

		ds1.namevalue(row,"GIVPRNM") = ds1.namevalue(row,"EMPNMK") ;
		
		
		alert(ds1.namevalue(row,"EMPNMK"));
		alert(ds1.namevalue(row,"GIVPRNM"));	

		alert(	ds1.namevalue(row,"EMPJUNO"));
		alert(ds1.namevalue(row,"GIVPRNO"));

	
		ds1.namevalue(row,"GIVPRNO") = ds1.namevalue(row,"EMPJUNO");
		
		alert(	ds1.namevalue(row,"EMPJUNO"));
		alert(ds1.namevalue(row,"GIVPRNO"));


}else if (ds1.namevalue(ds1.rowposition,"GIVCOD")== '42'){
		ds1.namevalue(row,"GIVPRCD") = '1' ;
		ds1.namevalue(row,"GIVPRNM") = ds1.namevalue(row,"EMPNMK") ;
		ds1.namevalue(row,"GIVPRNO") = ds1.namevalue(row,"EMPJUNO");
}else {
	for(i=1;i<=gcds_ds2.countrow;i++){
alert("a");
		alert("i::"+i+"GIVPRNM::::::"+ds1.namevalue(row,"GIVPRNM"));
		alert(":::::"+gcds_ds2.namevalue(i,"GIVPRNM")+"::::");
		if(ds1.namevalue(row,"GIVPRNM")== gcds_ds2.namevalue(i,"GIVPRNM")){ 
        //alert("b");
				ds1.namevalue(row,"GIVPRNO") = gcds_ds2.namevalue(i,"GIVPRNO"); 
        //alert("c");
			
				if(gcds_ds2.namevalue(i,"GIVPRCD") == '0' ) {
          //alert("d");
					ds1.namevalue(row,"GIVPRCD") = '1';
				}else if(gcds_ds2.namevalue(i,"GIVPRCD") == '3' ) {
          //alert("e");
					ds1.namevalue(row,"GIVPRCD") = '2';
				}else if(gcds_ds2.namevalue(i,"GIVPRCD")== '4' ) {
          //alert("f");
					ds1.namevalue(row,"GIVPRCD") = '3';
				} 
				break; 
       //alert("g");
		}
     //alert("h");
 	}
    //alert("i");
}
</script>


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
	<!-- �������� �� �����׸� -->
	<table width="975" border="0" cellspacing="1" cellpadding="3">
		<tr bgcolor="#FFFFFF">
			<td colspan="12" height="85">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td colspan="3">�� �Է¾ȳ�</td>
					</tr>
					<tr>
						<td width="10">&nbsp;</td>
						<td><font color="#000000">1. ��� �׸���� ��Ȯ�� ������ �Է��ϼž� �մϴ�.</font></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633"><b>2. ���ó�� ����ڵ�Ϲ�ȣ(������ȣ), ��ǥ�� �ֹε�Ϲ�ȣ(��- ������ ��ϴ� ���� ��� ��������) �� �ش��ȣ�� �Է��Ͻø� �˴ϴ�.</font></b>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;�� ��ġ�ڱݱ�α��� ����ڵ�Ϲ�ȣ�� �Է����� �ʽ��ϴ�.</font></b>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">3. <b><u>�ٷ��� ������ ���� ���ó�� ���� �� ����� ��� "���� �Ѿ�"�� �Է��Ͻø� �˴ϴ�.</u></font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">&nbsp;&nbsp;&nbsp;&nbsp;�� ���� ������ �ݾ��� �Է�</font></b></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#FF6633">4. �ٷ��� ���θ��Ƿ� ����� �ݾ׸��� �Է��ϼž� �մϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(���������� ��α��� �ҵ���� �Ұ�)</font>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td><font color="#000000">5. ���������� ���ó ���� �Է¼����� ��ġ�ǵ��� �����Ͽ� �ֽñ� �ٶ��ϴ�.<br>
						&nbsp;&nbsp;&nbsp;&nbsp;(A4ũ�⺸�� ���� ���������� A4 �̸����� ���� �� ������)</font>
						</td>
					</tr>

					<tr>
						<td>&nbsp;</td>
						<td align="right"><br>
						<nobr>
							<!-- <img src="../Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()"> -->
							<img src="../Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRow()">
							<img src="../Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRow()">
							<img src="../Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="../Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
							&nbsp;&nbsp;<img src="../Sales/images/p_exit.gif"	style="cursor:hand"	align=absmiddle onclick="fnClose()">
						</nobr>&nbsp;</td>
					</tr>					
				</table>
			</td>
		</tr>
	</table>

<%=HDConstant.COMMENT_START%>			
<OBJECT id=gr1  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 style="WIDTH: 970px; HEIGHT: 300px;border:1 solid #777777;display:;" viewastext>
	<PARAM NAME="DataID"		VALUE="ds1">
	<param name="ColSizing"		value="true">
	<param name="Fillarea"		value="false">
	<param name="Editable"		value="true">
	<param name="BorderStyle"	value="0">
	<param name=SortView  		value="Left">
	<Param Name="UsingOneClick" value="1">
	<param name=IndWidth" value="20">
	<param name="SuppressOption"    value="1">
	<param name="Format" 			value="  
	<FC> Name='�ͼӳ��'		ID=APPDT   		Width=60	HeadAlign=Center align=center  mask='XXXX-XX'  EDIT=NONE SUPPRESS=1 show=false</FC>
	<G> name='�ٷμҵ���' Width=70
		<FC> Name='����'		ID=EMPNMK  		Width=70	HeadAlign=Center align=center  EDIT=NONE SUPPRESS=2</FC>
		<FC> Name='�ֹι�ȣ'	ID=EMPJUNO  	Width=0	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX'  EDIT=NONE SUPPRESS=2 show=false</FC>
	</G>
	<G> name='�� ��'
		<FC> Name='����'		ID=GIVCOD		Width=80	HeadAlign=Center align=center EditStyle=Combo 
			 Data='10:������α�,20:��ġ�ڱ�,21:�������⿬,30:Ư�ʱ�α�,31:���ι��α�ν�Ź��θ�,42:�츮��������,40:������α�,41:������ü,50:��Ÿ�� ��α� '</FC>
	</G>
	<G> name='����'
		<C> Name='��'		  ID=GIVYEAR 		Width=35	HeadAlign=Center align=center EDIT=FALSE </C>	
		<C> Name='��'		  ID=GIVMONTH		Width=35	HeadAlign=Center align=center EditStyle=Combo
			Data='01:1��,02:2��,03:3��,04:4��,05:5��,06:6��,07:7��,08:8��,09:9��,10:10��,11:11��,12:12��'</C>
	</G>
	<G> Name='�����'
		<FC> Name='����'		  ID=GIVPRNM  		Width=50	HeadAlign=Center align=center  EditStyle=Lookup	Data='gcds_ds2:GIVPRNM' </FC>
		<FC> Name='�ֹι�ȣ'	ID=GIVPRNO  	Width=90	HeadAlign=Center align=center mask='XXXXXX-XXXXXXX' EDIT=NONE </FC>
		<FC> Name='����'		 ID=GIVPRCD	Width=53	HeadAlign=Center align=center  EditStyle=Combo
		 Data='1:����,2:�����,3:������' </FC>
	</G>
	<C> Name='��γ���'		  ID=GIVJYO     Width=150	HeadAlign=Center align=LEFT show=TRUE	SUPPRESS=2</C> 		
	<G> name='���ó'
	    <C> Name='��αݿ�����No'    		ID=GIVNO		Width=92	HeadAlign=Center align=center </C>	
		<C> Name='��ȣ(���θ�,��ü��)'		ID=GIVCOMP		Width=130	HeadAlign=Center align=center </C>	
		<C> Name='����ڵ�Ϲ�ȣ'			ID=GIVSAUP		Width=90	HeadAlign=Center align=center  EDIT=NUMERIC </C>	
	</G>		
	<G> name='����û �ڷ� show=false'
		<C> Name='�Ǽ�'		ID=GIVCNT1		Width=30	HeadAlign=Center align=center show=false EDIT=none</C>	
		<C> Name='�ݾ�'		ID=GIVAMT1		Width=65	HeadAlign=Center align=RIGHT  show=false EDIT=none dec=0</C>	
	</G>
	<G> name='�׹��� �ڷ�'
		<C> Name='�Ǽ�'		ID=GIVCNT2		Width=30	HeadAlign=Center align=center  EDIT=NUMERIC</C>	
		<C> Name='�ݾ�'		ID=GIVAMT2		Width=65	HeadAlign=Center align=RIGHT  EDIT=NUMERIC dec=0</C>	
	</G>

	<C> Name='���'	    	ID=EMPNO  		Width=60	HeadAlign=Center align=center show=false SUPPRESS=2</C> 	
	<C> Name='Flag'	    	ID=FLAGCOL		Width=20	show=false</C>	
	">
</OBJECT>	
<%=HDConstant.COMMENT_END%>

</form>
</body>
</html>