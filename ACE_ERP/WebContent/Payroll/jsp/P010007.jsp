<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<html>
<head>
    <jsp:include page="/Payroll/common/include/head.jsp"/>
<title>����������</title>
<%@ page import="Payroll.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>

<script language="javascript">
get_cookdata();
var gs_date = gcurdate.substr(0,4) + gcurdate.substr(5,2) + gcurdate.substr(8,2);
var gs_date2 = gcurdate.substr(0,4)+ "/" + gcurdate.substr(5,2)+ "/" + gcurdate.substr(8,2);

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
	/*txt_usrid.value = "";
	txt_usrpw.value = "";
	txt_usrnm.value = "";
	gcem_strdate.text = "";
	gcem_enddate.text = "";*/
  	var THeader ="EVACD:String(4),DIVCD:String(4),GRPCD:String(4),JOBGRPH:String(4),DETCD:String(4),"
	            +"SEQ:Decimal(2),ASK:String(70),EXCSCR:String(4),GODSCR:String(4),MIDSCR:String(4),"
	            +"LACSCR:String(4),PROSCR:String(4),WRDT:String(8),WRID:String(6),UPDT:String(8,"
	            +"UPID:String(6)";
	
	/*	for (var k=1; k<7; k++){
		if(k>=1 && k <= 5)THeader +="param"+k+":String(30)";
		if(k!=1)THeader +="param"+k+":Decimal(3)";
		if (k<6) THeader +=",";
	}*/

	gcds_pyo.ClearAll();
	gcds_pyo.DataID = "";
	gcds_pyo.SetDataHeader(THeader);

	gcds_pyo.RowPosition = 1;

	/*tb_DataSet_2.DataID="./gc/ds_acio_acct_gubn.jsp?NOH=Y";
    tb_DataSet_2.Reset();
    tb_DataSet_2.InsertRow(1);
    tb_DataSet_2.NameValue(1,"TONG_CODE")="%";
    tb_DataSet_2.NameValue(1,"TONG_1NAM")="��ü";
    ddlb_acct_gubn.index=0;*/

}

function ln_query(){

	//gcds_pyo.DataID = "<%=dirPath%><%=HDConstant.PATH_COMMON%>hdasan_user?gstr1=A&gstr2="; 
	//gcds_pyo.Reset(); 

	//ln_format('A');
	lbl_search.innerText = gcds_pyo.countrow + " ��";
}

function ln_add(){
	gcds_pyo.addrow();
	//ln_format('B');
	//txt_usrid.focus();
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRID") = gusrid;
	gcds_pyo.namevalue(gcds_pyo.rowposition,"WRDT") = gs_date;
	//alert(gcds_pyo.namevalue(gcds_pyo.rowposition,"WRID"));
	//alert(gcds_pyo.namevalue(gcds_pyo.rowposition,"WRDT"));
}
function ln_chk(){
    for (var i=1; i<=gcds_pyo.countrow; i++){
		if (gcds_pyo.namevalue(i,"EVACD")=="")
		{alert("�з��ڵ带 �����ϼ���"); ddlb_evacd.Focus();gcds_pyo.rowposition=i; return false;
		}
		if (gcds_pyo.namevalue(i,"DIVCD")==""){ alert("���������� �����ϼ���");ddlb_divcd.Focus();gcds_pyo.rowposition=i; return false;
		}
		if (gcds_pyo.namevalue(i,"GRPCD")==""){ alert("���ޱ����� �����ϼ���");ddlb_grpcd.Focus();gcds_pyo.rowposition=i; return false;
		}
		if (gcds_pyo.namevalue(i,"JOBGRPH")==""){ alert("���������� �����ϼ���");ddlb_jobgrph.Focus();gcds_pyo.rowposition=i; return false;
		}
		if (gcds_pyo.namevalue(i,"DETCD")==""){ alert("���з��� �����ϼ���");ddlb_detcd.Focus();gcds_pyo.rowposition=i; return false;
		}
		
	}
	return true;
}

function ln_save(){
  if(ln_chk())
  {
	if (gcds_pyo.IsUpdated) {
		if (confirm("����� ������ �����Ͻðڽ��ϱ�?")) {
			for (var i=1; i<=gcds_pyo.countrow; i++){
				if (gcds_pyo.sysStatus(i)!=0) {
					gcds_pyo.namevalue(i,"UPID") = gusrid;
					gcds_pyo.namevalue(i,"UPDT") = gs_date;
				}
				
				if (gcds_pyo.namevalue(i,"ASK")==""){
					gcds_pyo.undo(i);
				}
			}

 	    gctr_pyo.action = "<%=dirPath%><%=HDConstant.PATH_COMMON%>hdasan_h060001_tr";
			gctr_pyo.post();
		}
	}
  }
}

function ln_del(){
	if (confirm("������ ������ �����Ͻðڽ��ϱ�?")){
		gcds_pyo.deleterow(gcds_pyo.rowposition);
    gctr_pyo.action = "<%=dirPath%><%=HDConstant.PATH_COMMON%>hdasan_h060001_tr";
		gctr_pyo.post();
	}
}

/*function ln_format(arg){
	if (arg=='A') {
		txt_usrid.disabled = "true";
		txt_usrpw.disabled = "true";
	} else {
		txt_usrid.disabled = "";
		txt_usrpw.disabled = "";
	}
}*/
function ln_visible_hidden(Obj){
	if(Obj=="gcgd_create")
	{
		document.all.gcgd_create.style.display="block";
		document.all.div_create.style.display="block";
		document.all.gcgd_select.style.display="none";
		document.all.div_select.style.display="none";
		}
	else
	{
    	document.all.gcgd_create.style.display="none";
		document.all.div_create.style.display="none";
		document.all.gcgd_select.style.display="block";
		document.all.div_select.style.display="block";
	}
}

</script>

<!--*****************************************************************************
//'  ����Ÿ�� ����
//'****************************************************************************-->
<comment id="__NSID__"><object id="gcds_pyo" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
	<PARAM NAME="SYNCLOAD" VALUE="TRUE">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><OBJECT id=gctr_pyo classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="hdasan_h060001_tr(I:USER=gcds_pyo)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<script language="javascript" for="gcgd_pyo" event="onclick(row)">
	/*if (row == 0) return;
	if (gcds_pyo.sysStatus(row)==0) ln_format('A');
	else ln_format('B');*/
</script>

</head>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!--*****************************************************************************
//'  �ں�����Ÿ�� ����
//'****************************************************************************-->
<!--�з��ڵ�-->
<comment id="__NSID__"><object id="gcds_evacd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
</object></comment><script>__ws__(__NSID__);</script>
<!--��������-->
<comment id="__NSID__"><object id="gcds_divcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
</object></comment><script>__ws__(__NSID__);</script>
<!--���ޱ���-->
<comment id="__NSID__"><object id="gcds_grpcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
</object></comment><script>__ws__(__NSID__);</script>
<!--��������-->
<comment id="__NSID__"><object id="gcds_jobgrph" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
</object></comment><script>__ws__(__NSID__);</script>
<!--���з�-->
<comment id="__NSID__"><object id="gcds_detcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" > 
</object></comment><script>__ws__(__NSID__);</script>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td  background="../../Common/img/com_t_bg.gif"><img src="../img/p010007_head.gif"></td>
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
	        <img src="../../Common/img/btn/com_b_create.gif" style="cursor:hand" onclick="ln_del()">
			<img src="../../Common/img/btn/com_b_delete.gif" style="cursor:hand" onclick="ln_del()">
			<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand" onclick="ln_del()">
			 <img src="../../Common/img/btn/com_b_save.gif" style="cursor:hand" onclick="ln_save()">
			 <img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand" onclick="ln_query()">&nbsp;</td>
  </tr>
  <!--------------------------------------------------------------------------------> 
  <!------------------------    FORM ����κ�   ------------------------------------> 
  <!--------------------------------------------------------------------------------> 

  <tr> 
    <td COLSPAN=2>
	<table  cellpadding="0" cellspacing="0" border="0"      
	   style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
		                <td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;&nbsp;</nobr></td>
						<td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;<SELECT    
							id="nwgubn" name="nwgubn" STYLE="WIDTH:55;">
    			  				  <OPTION  Value="1">����</OPTION>
	    						  <OPTION  Value="2">����</OPTION>
	            				</SELECT>    
            			    &nbsp;</nobr></td>  
						<td width="10"   style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee"><nobr>&nbsp;���뿬��&nbsp;</nobr></td>
                        <TD style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp<comment id="__NSID__"><object id=ADE_EMEdit_ec01ay classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
				style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:dotum; font-size:9pt; " class=objclsEme1
				validFeatures="ignoreStatus=yes" validExp="">
				<param name=Text          value="">
				<param name=Alignment	  value=0>
				<param name=Border	      value=True>
				<param name=ClipMode	  value=true>
				<param name=Numeric	      value=false>
				<param name=Format	      value="YYYY/MM">
				<param name=MaxLength     value=6>
				<param name=PromptChar	  value="_">
				<param name=IsComma	      value=false>
				<param name=BackColor     value="#CCCCCC">
				<param name=InheritColor  value=false>
			    </object></comment><script>__ws__(__NSID__);</script>&nbsp</nobr></TD>
                        <td width="10"   style="border:0 solid #708090;border-right-width:1px;"      
						    bgcolor="#eeeeee"><nobr>&nbsp;�Ҽ�&nbsp;&nbsp;</nobr></td>
                        <td width="10" style="border:0 solid #708090;border-right-width:1px;"><nobr>&nbsp;<SELECT    
							id="nwgubn" name="nwgubn" STYLE="WIDTH:120;">
    			  				  <OPTION  Value="1">����</OPTION>
	    						  <OPTION  Value="2">��������</OPTION>
								  <OPTION  Value="3">��ȹ����</OPTION>
								  <OPTION  Value="4">��ȹ(�ؿ�)</OPTION>
								  <OPTION  Value="5">���ȫ��</OPTION>
								  <OPTION  Value="6">��ܻ��</OPTION>
								  <OPTION  Value="7">�渮</OPTION>
								  <OPTION  Value="8">�ѹ���</OPTION>
								  <OPTION  Value="9">�������</OPTION>
								  <OPTION  Value="10">���������</OPTION>
								  <OPTION  Value="11">����</OPTION>
								  <OPTION  Value="12">��ü</OPTION>
	            				</SELECT>    
            			    &nbsp;&nbsp;</nobr></td>  
                        <td width="10"   style="border:0 solid #708090;border-right-width:1px;"      
						    bgcolor="#eeeeee"><nobr>&nbsp;����&nbsp;&nbsp;</nobr></td>
                        <td >&nbsp;<nobr><INPUT TYPE=TEXT STYLE="width:90px;" ></nobr></td> 
						<td width="100%" style="border:0 solid #708090;border-right-width:0px;"><nobr>&nbsp;
            			    </nobr></td>    
		</tr>
	</table>		
	</td>
  </tr>
  
  <tr> 
  <td height=3></td>
  </tr>  



  <tr> 
    <td colspan=2> 
      <table width="877" cellpadding="0" cellspacing="0" border="0">
        <tr> 
          <td  >
						<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_create  
						style="WIDTH: 876px; HEIGHT: 420px;border:1 solid #777777;display:block;" viewastext>
                          <PARAM NAME="DataID"			VALUE="gcds_pyo">
                          <PARAM NAME="Editable" VALUE="True">
                          <PARAM NAME="BorderStyle" VALUE="0">
			              <param name="Fillarea"		VALUE="true">
			              <PARAM NAME="Format"			VALUE="  
								<C> Name='����' ID=GODSCR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=40 Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric </C> 
								<C> Name='���' ID=EXCSCR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  
								    Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric  </C> 
								<C> Name='����' ID=EXCSCR  	HeadAlign=Center HeadBgColor=#B9D4DC Width=70  
								    Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric  </C> 
								
								<C> Name='�Ҽ�' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=140 Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<C> Name='�Ի���' ID=PROSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=80 Mask=X.XX 
								NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<G> Name='�߻��ϼ�' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC
								<C> Name='�ݿ��߻�' ID=PROSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX 
								NameMask=X.XX align=RIGHT Edit=Numeric </C>
								<C> Name='������ġ' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<C> Name='��' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX 
								</G>
								NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<C> Name='����' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX 
								NameMask=X.XX align=RIGHT Edit=Numeric  </C>

								<C> Name='�����ϼ�' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<C> Name='��ġ�ϼ�' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=60 Mask=X.XX 
								NameMask=X.XX align=RIGHT Edit=Numeric  </C>
								<C> Name='��������' ID=MIDSCR HeadAlign=Center HeadBgColor=#B9D4DC Width=88 Mask=X.XX 
								NameMask=X.XX align=RIGHT Edit=Numeric  </C>

       							">
                        </OBJECT></comment><script>__ws__(__NSID__);</script>
		  </td>
		
        </tr>
      </table>
    </td>
  </tr>

</table>

<comment id="__NSID__"><object id=gcbn_pyo classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_pyo>
	<param name=BindInfo  value='
		<C>Col=EVACD    Ctrl=ddlb_evacd       Param=BindColVal</C>
		<C>Col=DIVCD  Ctrl=ddlb_divcd       Param=BindColVal</C>
		<C>Col=GRPCD  Ctrl=ddlb_grpcd       Param=BindColVal</C>
		<C>Col=JOBGRPH   Ctrl=ddlb_jobgrph    Param=BindColVal</C>
		<C>Col=DETCD   Ctrl=ddlb_detcd    Param=BindColVal</C>
	'>
</object></comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	



