<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: ���� ���� ���� 
+ ���α׷� ID  :  xat_dfscost_popup
+ �� �� �� ��	: ��ȸ
+ ��    ��     ��  : ������
+ ��  ��  ��  ��  : 2018.04.25
-----------------------------------------------------------------------------
+ �� �� �� ��	:
+ �� �� �� ��	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>���� ���� ����</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function ln_Start(){
	gcra_gubun.codevalue="T";
	
	strParam = window.dialogArguments;
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(e){
	
		gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>xat_dfscost_popup_s1?+v_str1="+ txt_nm.value
									                                                  + "&v_str2=" + gcra_gubun.codevalue
									                                                  + "&v_str3=" + strParam; 								 
	    gcds_data.Reset();
}

/******************************************************************************
	Description : �߰�
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Save(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : ����
******************************************************************************/
function ln_Excel(){

}

/******************************************************************************
	Description : â�ݱ�
******************************************************************************/
function ln_Close(e){
    var strIncode ="";
    var intCnt =0;
	if (e=="A") {
		    
		    //������ 
		    for (var i =1; i<=gcds_data.countrow;i++ ){
		    	if(gcds_data.namevalue(i,"CHK")=="T"){
		    	    intCnt +=1;
		    	   
		    	    if (intCnt ==1){
		    	   		strIncode =  gcds_data.namevalue(i,"INCODE");    
		    		}else{
		    			strIncode = strIncode+"','"+ gcds_data.namevalue(i,"INCODE");    
		    		}
		    	}
		    }
		    
		    if (intCnt>0){
			    window.returnValue =strIncode;
			    window.close();
		    }
		    
	} else {
		window.close();
	}
}
</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	ft_cnt1.innerText="����Ÿ ��ȸ���Դϴ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>
<script language="javascript" for="gcds_data" event="onloadCompleted(row,colid)">
	ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	if(gcds_data.countrow <=0)
			alert("��ȸ�� ����Ÿ�� �����ϴ�.");
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp" event="OnDblClick()">
	ln_Close('A');
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table border="0" cellpadding="0" cellspacing="0" style="position:relative;left:5px;top:5px;width:455px;border:1 solid #708090">
	<tr>
		<td class="tab12" width="50px;" bgcolor="#eeeeee">��������</td>
		<td width="110px"><input type="text" class="txt11" id="txt_nm" style="width:80px;" onkeydown="if(event.keyCode==13) ln_Query();"></td>
		<td class="tab41" width="50px;" bgcolor="#eeeeee">����</td>
		<td width="200px">
		   <comment id="__NSID__"> 
		   <object id=gcra_gubun classid=CLSID:754F3DC4-0C79-4C92-AD64-A806D8FF2AB0 style="height:24; width:170">
			<param name=Cols	value="3">
			<param name=Format	value="T^���,F^�̻��,0^��ü">
           </object>
		   </comment><script>__ws__(__NSID__);</script>
		</td>
		
		<td><img src="../../Common/img/btn/com_b_find.gif" alt="������ �˻��մϴ�" style="position:relative;left:0px;top:0px;cursor:hand;" onclick="ln_Query()"></td>
	</tr>
</table>
<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:5px;top:10px">
	<tr>
		<td class="tab21" colspan="3">
			<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:455;height:239px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
		       <PARAM NAME="DataID"			VALUE="gcds_data">
			   <PARAM NAME="BorderStyle"    VALUE="0">
			   <PARAM NAME="Indwidth"		VALUE="0">
			   <param name="Editable"		value='true'> 
				<PARAM NAME="Fillarea"		VALUE="true">
				<param name="sortview"      value=left>
			    <PARAM NAME="Format"		VALUE="  
			        <C>ID=CHK,		    Name=����,		 width=30,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center  EditStyle=CheckBox </C>
					<G> Name='��������'	 HeadAlign=Center HeadBgColor=#B9D4DC
					<C>ID=INCODE,		Name=�ڵ�,	    width=70,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  edit=none</C>
					<C>ID=INCODENM,		Name=�����,		width=110,		HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none</C>
					</G>
					<G> Name='��������'	 HeadAlign=Center HeadBgColor=#B9D4DC
					<C>ID=OUTCODE,		Name=�ڵ�,	    width=70,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none</C>
					<C>ID=OUTCODENM,	Name=������,	    width=110,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true  edit=none</C>
					</G>
					<C>ID=USEGB,	    Name=���\\����,	width=50,	    HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,   sort = true EditStyle=Combo Data='T:���,F:�̻��'   edit=none</C>
				">
	    </OBJECT></comment><script>__ws__(__NSID__);</script>
		</td>
	</tr>
	<tr>
		<td>
			<fieldset id=ft_div1 style="width:458;height:20px;border:1 solid #708090;border-top-width:0px;text-align:left;">
				&nbsp;<font id=ft_cnt1 style="position:relative;top:3px;"></font>
			</fieldset>
		</td>
	</tr>
	<tr><td height="4px"></td></tr>
	<tr>
		<td height="30px;" align="center">
			<img name="btn_select" border="0" src="../../Common/img/btn/com_b_select.gif" style="cursor:hand" onClick="ln_Close('A')">
			<img name="btn_close" border="0" src="../../Common/img/btn/com_b_close.gif" style="cursor:hand" onClick="ln_Close('C')">
		</td>
	</tr>
</table>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	