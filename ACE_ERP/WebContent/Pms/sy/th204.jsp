<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ���¾�ü ����
 * ���α׷�ID 	: thms204.HTML
 * J  S  P		: th204.jsp
 * �� �� ��		: �̵���
 * �� �� ��		: 2010-10-07
 * �������		: ��������� ���¾�ü ���� (�ϵ���ȸ��)
 * [ �������� ][������] ����
 * [2011-06-16][�ɵ���] ������� ������ ����
 * [2011-06-17][�ɵ���] ���¾�ü �ڵ尡 �������� ���߹������̺��� ��������� �� �׼� �����Ϳ� �ٸ�!
 *						�� ���¾�ü�� ���հ����ϴ� �� �����ؾ� ���� �ʳ�?
 *						ȸ�� �ʿ� ��ϿϷ� �ߴٴ� Flag�� �ϳ� �ʿ�������..
 *  �������� : thms_101_s.java, thms_101_t.java
 *****************************************************************************/
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>

<html>
<head>
<title>���¾�ü ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="http://erp.hdasan.com/common/include/common.css">
 
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="http://erp.hdasan.com/common/include/PubFun.js"></script>


<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

	get_cookdata();       //�б�

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){

	ln_Before();		//����ȸ ����



}


/******************************************************************************
	Description : ����ȸ ����
******************************************************************************/
function ln_Before(){

	gclx_regyy.index = 1;

	ln_SetDataHeader();//gcds_data00 �ش�����

	//����
	gcds_regyy.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0006";
	gcds_regyy.Reset();

	//����
	gcds_cnst.DataID="<%=dirPath%>/servlet/construct.menu.th.thms_site_s?v_str1=0003";	
	gcds_cnst.Reset();

}


/******************************************************************************
	Description : Dataset Head ���� - gcds_data00
******************************************************************************/
	function ln_SetDataHeader(){
			if(gcds_data00.countrow<1){
				var s_temp =  "COOP_CD:STRING(10),"		
									+"COOP_NM:STRING(50)," 			
									+"COOP_YYMM:STRING(10)," 		
									+"COOP_VGB:STRING(1)," 										
									+"COOP_CERT:STRING(15),"	
									+"COOP_DIRECT:STRING(20),"    											
									+"ADDRESS:STRING(20),"		
									+"COOP_STYLE:STRING(20),"
									+"CREAT_DT:STRING(10),"							
									+"LICENSE1:STRING(30),"			
									+"CON_CAPA1:DECIMAL(15,0),"   												
									+"LICENSE2:STRING(30),"	
									+"CON_CAPA2:DECIMAL(15,0),"  											
									+"LICENSE3:STRING(30),"	
									+"CON_CAPA3:DECIMAL(15,0),"  												
									+"DEBT_2008:STRING(20),"
									+"DEBT_2009:STRING(20),"
									+"DEBT_2010:STRING(20),"
									+"DEBT_2011:STRING(20),"
									+"CASH_2008:STRING(20),"
									+"CASH_2009:STRING(20),"
									+"CASH_2010:STRING(20),"
									+"CASH_2011:STRING(20),"
									+"CREDIT_2008:STRING(20),"
									+"CREDIT_2009:STRING(20),"
									+"CREDIT_2010:STRING(20),"
									+"CREDIT_2011:STRING(20),"
									+"DEFAULT:STRING(50),"			
									+"PATENT:STRING(50),"		
									+"RECOMMEND:STRING(50),"											
									+"VD_TELNO:STRING(15),"			
									+"VD_FAXNO:STRING(15),"		
									+"REMARK:STRING(100)"							
				gcds_data00.SetDataHeader(s_temp);		
		}
	}

/******************************************************************************
	Description : �⺻��ȸ
******************************************************************************/
function ln_Query(){

	gcds_data00.DataID = "<%=dirPath%>/servlet/construct.menu.th.thms_204_s1?"	 		
											 + "v_str1="+gclx_regyy.bindcolval						//��ϳ⵵
											 + "&v_str2="+gclx_cnst.bindcolval;						//��ü����

	gcds_data00.Reset(); 

}

/******************************************************************************
	Description : ����  -   �ϼ��ؾ� ��!!!!
******************************************************************************/
function ln_Save(){

    //if(!ln_Save_Chk()) return;

	if (gcds_data00.IsUpdated) {	
		if (confirm("�ش� �Է������� �����Ͻðڽ��ϱ� ?")) {
			gctr_sys.KeyValue = "thms_204_t1?(I:USER=gcds_data00)";			
 			gctr_sys.action = "<%=dirPath%>/servlet/construct.menu.th.thms_204_t1?";
			gctr_sys.post();

		}
	}
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

        gcds_data00.AddRow();

		gcem_coopnm.Text = "";      		
		gcem_coopstyle.Text = "";      		
		gcem_coopcd.Text = "";		    
		gcem_coopcert.Text = "";      		
		gcem_coopaddress.Text = "";      	
		gcem_coopdirect.Text = "";	      	
		gcem_recommend.Text = "";	    		
		gcem_coopdebt_2008.Text = "";   
		gcem_coopdebt_2009.Text = "";   
		gcem_coopdebt_2010.Text = "";   
		gcem_coopcash_2008.Text = "";  
		gcem_coopcash_2009.Text = "";  
		gcem_coopcash_2010.Text = "";  
		gcem_coopcredit_2008.Text = "";      		
		gcem_coopcredit_2009.Text = "";      	
		gcem_coopcredit_2010.Text = "";      	
		gcem_cooplicense1.Text = "";      	
		gcem_cooplicense2.Text = "";      	
		gcem_cooplicense3.Text = "";      	
		gcem_coopcapa1.Text = "";	    
		gcem_coopcapa2.Text = "";      	
		gcem_coopcapa3.Text = "";     	
		gcem_coopdefault.Text = "";	    
		gcem_cooppatent.Text = "";  
		gcem_coopremark.Text = "";

		gcem_coopnm.focus();

}


/******************************************************************************
	Description : ����
******************************************************************************/
  function ln_Excel(){

    var szName1 = "��ü�� ��Ȳ";
    var szPath = "C:\\Test\\��Ȳ.xls";
       if (gcds_data00.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }


</script>

<!-- ������  -->
<script language="javascript" 	for="gcds_cnst" event="onloadCompleted(row,colid)">
	gcds_cnst.namevalue(1,"COM_CODE") = "";
	gcds_cnst.namevalue(1,"COM_SNAME") = "��ü";
	gclx_cnst.index = 0;
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_regyy classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__">
<OBJECT id=gcds_cnst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__">
<object id=gctr_data00 classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-- ��ü ��ȸ -->
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
</script>

<script language=JavaScript for=gctr_data00 event=OnFail()>
	alert("Error Code : " + gctr_data00.ErrorCode + "\n" + "Error Message : " + gctr_data00.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data00 event=OnSuccess()>
    alert("���忡 �����Ͽ����ϴ�");
	ln_Query();		
</script>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
</head>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->	
<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px" height="47" background="http://erp.hdasan.com/common/img/com_t_bg.gif">
<tr> 
			<td width="876" height = "30" align="right" background="http://erp.hdasan.com/common/img/com_t_bg.gif">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_newadd.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Add()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_save.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Save()">
						<img src="http://erp.hdasan.com/common/img/btn/com_b_excel.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Excel()">	
						<img src="http://erp.hdasan.com/common/img/btn/com_b_query.gif" style="position:relative;top:3px;cursor:hand" onclick="ln_Query()">								

			</td>
</tr>
</table>

<table  cellpadding="0" cellspacing="0" border="1"  style='position:relative;;left:7px;width:870px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
		<tr> 
				<td class="tab21" style="height:30px;width:70px;" bgcolor="#eeeeee">&nbsp;&nbsp;��ϳ⵵</td>
				<td class="tab21">
				<comment id="__NSID__">
				<object id="gclx_regyy" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
								<param name="ComboDataID" value="gcds_regyy" />
								<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
								<param name="SearchColumn" value="COM_SNAME" />
								<param name="Sort" value="false" />
								<param name="Index" value="0" />
								<param name="ListExprFormat" value="COM_SNAME^0^320" />
								<param name="BindColumn" value="COM_CODE" />
				</object>
				</comment><script>__ws__(__NSID__);</script>
				</td>
				<td class="tab21" style="height:30px;width:70px;" bgcolor="#eeeeee">&nbsp;&nbsp;��ü��</td>
				<td class="tab21"  colspan = "3">
				<comment id="__NSID__">
				<object id="gclx_cnst" classid="clsid:60109D65-70C0-425C-B3A4-4CB001513C69" style="position: relative; left: 5px; top: 1px; font-size: 12px; width: 320px">
										<param name="ComboDataID" value="gcds_cnst" />
										<param name="CBDataColumns" value="COM_CODE, COM_SNAME" />
										<param name="SearchColumn" value="COM_SNAME" />
										<param name="Sort" value="false" />
										<param name="Index" value="0" />
										<param name="ListExprFormat" value="COM_SNAME^0^320" />
										<param name="BindColumn" value="COM_CODE" />
				</object>
				</comment><script>__ws__(__NSID__);</script>
				</td>				
		</tr>

</table>




<table style ="position:relative" border="0" cellpadding="0" cellspacing="0" width="0">
	<tr>
		<td valign="top" bgcolor="#FFFFFF"style="padding-top:3px;">
			<table border = "0" cellpadding=0 cellspacing=0 style="width:620px;height:450px;float:left;left:3px;top:-1px">
				<tr height="1"><td></td></tr>
				<tr>
						<td width="0" style="padding-left:3px;">
										<comment id="__NSID__">
										<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp
										width="615" height="450" style="border:1 solid #708090" >
										<PARAM NAME="DataID"            VALUE="gcds_data00">
										<PARAM NAME="BorderStyle" VALUE="0">
										<PARAM NAME="Indwidth"      VALUE="0">
										<PARAM NAME="Fillarea"      VALUE="true">
										<PARAM NAME="Colsizing"     VALUE="true">
										<param name="editable"      value="true">
										<param name="sortview"     value=left>
										<PARAM NAME="Format"            VALUE="
										<F> Name=NO					ID={CurRow}       HeadAlign=Center   HeadBgColor=#B9D4DC Width=40,  align=center </F>
										<C>Name=�ڵ�,				ID=COOP_CD		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center sort = true </C>
										<C>Name=�����ü��,		ID=COOP_NM		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center, sort = true  </C>
										<C>Name=��ϳ⵵,			ID=COOP_YYMM		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center, sort = true  </C>
										<C>Name=����ڵ�Ϲ�ȣ,      ID=COOP_CERT	HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=110,align=center sort = true  </C>

										<C>Name=��ǥ��,			ID=COOP_DIRECT			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=center</C>
										<C>Name=������,			ID=ADDRESS					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=center</C>
										<C>Name=����,  				ID=COOP_STYLE			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=������,  			ID=CREAT_DT				HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center</C>

										<C>Name=����1,  			ID=LICENSE1			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=�ð��ɷ�1,       ID=CON_CAPA1		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=����2,  			ID=LICENSE2			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=�ð��ɷ�2,       ID=CON_CAPA2		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=����3,  			ID=LICENSE3			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=�ð��ɷ�3,       ID=CON_CAPA3		HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>

										<G>Name=��ä����,     HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008��,  	ID=DEBT_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009��,  	ID=DEBT_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010��,  	ID=DEBT_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<G>Name=�����帧,  	HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008��,  	ID=CASH_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009��,  	ID=CASH_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010��,  	ID=CASH_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<G>Name=�ſ뵵,  		HeadBgColor=#B9D4DC, HeadAlign=center
										<C>Name=2008��,  	ID=CREDIT_2008			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2009��,  	ID=CREDIT_2009			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=2010��,  	ID=CREDIT_2010			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										</G>

										<C>Name=ä��������,  ID=DEFAULT					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=Ư����Ȳ,  	ID=PATENT					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=��õ��,  		ID=RECOMMEND			HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=center</C>
										<C>Name=��ȭ,  			ID=VD_TELNO			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=�ѽ�,  			ID=VD_FAXNO			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=100,align=center</C>
										<C>Name=���,  			ID=REMARK					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=center</C>

										">
										</OBJECT>
										</comment><script>__ws__(__NSID__);</script>
										<fieldset style="width:615;height:25px;border:1 solid #708090;border-top-width:1px;text-align:left;">&nbsp;
										<font id=ft_cnt1 style="position:relative;top:4px;"></font>
										</fieldset>
						</td>
				</tr>
		</table>



          <td width=3> </td>



						<td valign=top align=left style="padding-top:3px;">


							<table  border="0" cellpadding="0" cellspacing="1" width="245px" bgcolor="#b5b5b5">
								<tr height="25">
									<td  align="center" bgcolor="#eeeeee" colspan="4"><B>�⺻�׸�</B>
									</td>
									</tr>

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee" >��ü��</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopnm" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >�־���</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopstyle" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">����ڵ�</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopcd" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>		

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee" >����ڹ�ȣ</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopcert" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >������</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopaddress" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">��ǥ��</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopdirect" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">��õ��</td>
										<td bgcolor="#FFFFFF"colspan="3">
										<comment id="__NSID__">
										<object id="gcem_recommend" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="width:180px;  height: 16px;">
												<param name=Alignment			value=0>
												<param name=Border				value=false>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>�ſ뵵��Ȳ </B>

										</td>
									</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >���λ���
										</td>
										<td  align="center" bgcolor="#eeeeee" >��ä����


										</td>
										<td  align="center" bgcolor="#eeeeee" >�����帧


										</td>
										<td  align="center" bgcolor="#eeeeee" >�ſ뵵


										</td>
										</tr>

										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" >2008��</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2008" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">									
										<td  align="center" bgcolor="#eeeeee">2009��</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2009" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">
										<td  align="center" bgcolor="#eeeeee">2010��</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopdebt_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:40px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=2>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										%</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcash_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:60px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" align="center">
										<comment id="__NSID__">
										<object id="gcem_coopcredit_2010" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:55px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>


										<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4"></td>
									</tr>
									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>�Ǽ��� ����</B>
										</td>
									</tr>


										<tr height="20">								
										<td  align="center" bgcolor="#eeeeee" rowspan = "3">�ð��ɷ� <br>(�鸸��)</td>
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense1" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa1" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">								
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense2" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa2" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>

										<tr height="20">
										<td bgcolor="#FFFFFF">
										<comment id="__NSID__">
										<object id="gcem_cooplicense3" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:50px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										<td bgcolor="#FFFFFF" colspan="2">
										<comment id="__NSID__">
										<object id="gcem_coopcapa3" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:100px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Numeric			value=true>
												<param name=IsComma			value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>
										</tr>


									<tr height="5">
									<td  align="center" bgcolor="#FFFFFF" colspan="4">
									</td>
									</tr>



									<tr height="25">
										<td  align="center" bgcolor="#eeeeee" colspan="4"><B>��Ÿ </B>
										</td>
									</tr>	
									<tr height="20">							
										<td  align="center" bgcolor="#eeeeee">ä��������</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopdefault" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=0>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>										
									</tr>		
									<tr height="20">
										<td  align="center" bgcolor="#eeeeee">Ư�㺸��</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_cooppatent" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=0>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>							
									</tr>									
									<tr height="20">							
										<td  align="center" bgcolor="#eeeeee">���</td>
										<td bgcolor="#FFFFFF" colspan="3">
										<comment id="__NSID__">
										<object id="gcem_coopremark" classid="CLSID:E6876E99-7C28-43AD-9088-315DC302C05F"
											tabindex="1" style="position:relative; left:1px;top:1px; width:180px; height:18px; font-family:����; font-size:9pt ">
												<param name=Alignment			value=1>
												<param name=Border				value=true>
												<param name=Format				value="">
												<param name=GeneralEdit		value="true">
										</object>
										</comment><script>__ws__(__NSID__);</script>
										</td>								

									</tr>

								</td>
							</tr>            
						</table>
						</td>








	<!-- �⺻�� -->
<comment id="__NSID__">
	<OBJECT id=gcbn_data00 classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
		<PARAM NAME="DataID"				VALUE="gcds_data00">
		<PARAM NAME="ActiveBind"		VALUE="true">
		<PARAM NAME="BindInfo"			VALUE="
			<C>Col=COOP_NM,				Ctrl=gcem_coopnm      						Param=Text</C>
			<C>Col=COOP_STYLE,			Ctrl=gcem_coopstyle      						Param=Text</C>
			<C>Col=COOP_CD,				Ctrl=gcem_coopcd		      					Param=Text</C>
			<C>Col=COOP_CERT,			Ctrl=gcem_coopcert      		  				Param=Text</C>
			<C>Col=ADDRESS,				Ctrl=gcem_coopaddress      					Param=Text</C>
			<C>Col=COOP_DIRECT,		Ctrl=gcem_coopdirect	      					Param=Text</C>
			<C>Col=DEBT_2008,			Ctrl=gcem_coopdebt_2008      				Param=Text</C>
			<C>Col=DEBT_2009,			Ctrl=gcem_coopdebt_2009      				Param=Text</C>
			<C>Col=DEBT_2010,			Ctrl=gcem_coopdebt_2010      				Param=Text</C>
			<C>Col=CASH_2008,			Ctrl=gcem_coopcash_2008      		 	Param=Text</C>
			<C>Col=CASH_2009,			Ctrl=gcem_coopcash_2009      		  	Param=Text</C>
			<C>Col=CASH_2010,			Ctrl=gcem_coopcash_2010      		  	Param=Text</C>
			<C>Col=CREDIT_2008,	    Ctrl=gcem_coopcredit_2008      		  	Param=Text</C>
			<C>Col=CREDIT_2009,		Ctrl=gcem_coopcredit_2009      		  	Param=Text</C>
			<C>Col=CREDIT_2010,    	Ctrl=gcem_coopcredit_2010      		  	Param=Text</C>
			<C>Col=LICENSE1,	  			Ctrl=gcem_cooplicense1      		  			Param=Text</C>	
			<C>Col=LICENSE2,	  			Ctrl=gcem_cooplicense2      		  			Param=Text</C>		
			<C>Col=LICENSE3,	  			Ctrl=gcem_cooplicense3      		  			Param=Text</C>	
			<C>Col=CON_CAPA1,	  		Ctrl=gcem_coopcapa1	      		  			Param=Text</C>	
			<C>Col=CON_CAPA2,	  		Ctrl=gcem_coopcapa2      		  			Param=Text</C>	
			<C>Col=CON_CAPA3,			Ctrl=gcem_coopcapa3      		  	  		Param=Text</C>	
			<C>Col=DEFAULT,				Ctrl=gcem_coopdefault	       					Param=Text</C>
			<C>Col=PATENT,	 	 			Ctrl=gcem_cooppatent      		  			Param=Text</C>
			<C>Col=RECOMMEND,	 	 	Ctrl=gcem_recommend      		  			Param=Text</C>
			<C>Col=REMARK,	 	 			Ctrl=gcem_coopremark      		  			Param=Text</C>
		">
	</OBJECT>
	</comment><script>__ws__(__NSID__);</script>





<!--------------------------------- �ڵ� �κ� �� -------------------------------->
<comment id="__NSID__"><object id=gcbn_date classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data>
	<param name=BindInfo  value='
	'>
</object></comment><script>__ws__(__NSID__);</script>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
</body>
</html>

