<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	: �ΰ����� - �ΰ������̷�
+ ���α׷� ID	: a400130.jsp
+ �� �� �� ��	: �ΰ������̷���ȸ
+ �� �� �� ��	: 2017.04.07 jys
+ ���콺 ����    : 5.2
-----------------------------------------------------------------------------
+ �� �� �� ��	:   
+ �� �� �� ��	:  
-----------------------------------------------------------------------------
------------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ �� �� �� ��	: a400120_s1, a400120_t1
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath ���� ����. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>

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

var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_userid = gusrid;

<%
/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
%>
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

    gcra_usegb_0.codevalue ="";	
	
    gcds_signet_gb_0.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2270&v_str2=&v_str3=&v_str4=C";   
	gcds_signet_gb_0.Reset();	
	
	gcds_signet_gb.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2270&v_str2=&v_str3=&v_str4=C";   
	gcds_signet_gb.Reset();	
}

/******************************************************************************
	Description : ��ȸ
******************************************************************************/
function ln_Query(){
	
	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a400130_s1?v_str1="+gclx_signet_gb_0.bindcolval
			                                                            +"&v_str2="+gcra_usegb_0.codevalue;
   //prompt('',gcds_data.DataID);
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
	Description : �Է°� üũ
******************************************************************************/
function ln_Chk_Save() {
    //�ʼ��׸� üũ     

}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Cancel(){
	
}

<%	
/******************************************************************************
	Description : ����
******************************************************************************/
%>
function ln_Delete(){
		
	
}

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){

}


</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_signet_gb_0 classid=clsid:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>


</comment><script>__ws__(__NSID__);</script> 
<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("������ �߻� �߽��ϴ�.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>//�� ��ȸ �Ǽ�
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if (rowcount ==0 ){
		alert("�˻��� ����Ÿ�� �����ϴ�.");
	}

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = "���������� ��ȸ�Ǿ����ϴ�.";
</script>

<script language="javascript" for="gcds_signet_gb_0" event="onloadCompleted(row,colid)">
    gcds_signet_gb_0.InsertRow(1);
    gcds_signet_gb_0.NameValue(1,"CDCODE")="";
    gcds_signet_gb_0.NameValue(1,"CDNAM")="��ü";
    gclx_signet_gb_0.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>


</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
	  	<td colspan=2>
	  		<table width="1000px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td height ="'vAlign="center"><strong><h4>&nbsp;</h4></strong></td>
					<td width="1000px" align="right"  style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"	style="cursor:hand" onclick="ln_Query()">
					</td>
				</tr>
			</table>
	    </td>  
	</tr>
	<tr>
	 	<td colspan=2>
			<table  cellpadding="0" cellspacing="0" style="width:1000px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="80px" align=center  bgcolor="#eeeeee" class="tab15" >�˻�</td>
					<td width="100px;" class="tab18"  bgcolor="#eeeeee" align="center">�ΰ�����</td>
					<td width="400px"  class="tab18"  align=left  >
				    	<comment id="__NSID__">
							<object  id=gclx_signet_gb_0  classid=clsid:D8BCC087-4710-427D-B2E4-A4B93B6EA197 	style="position:relative;left:5px;top:0px;font-size:12px;width:130px;">
									<param name=ComboDataID      value="gcds_signet_gb_0">
									<param name=CBDataColumns	 value="CDCODE,CDNAM">
									<param name=SearchColumn	 value="CDNAM">
									<param name=Sort			 value=true>
									<param name=SortColumn       value="CDCODE">
									<param name=ListExprFormat   value="CDNAM^0^100">								
									<param name=BindColumn		 value="CDCODE">
							</object>
						</comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab18" width="100px;" bgcolor="#eeeeee" align="center">�������</td>
					<td class="tab18" >&nbsp;
						<comment id="__NSID__">
						<object id=gcra_usegb_0 classid=CLSID:B22DC058-80A2-438F-A64D-08B3B04AD7E0 style="width:200px;height:20px" >
							<param name=Cols	value="4">
							<param name=Format	value="1^���,2^����,9^���,^��ü">
						</object></comment><script>__ws__(__NSID__);</script>
					</td> 	 
				</tr>
			</table>
		</td>
    </tr>
	<tr>
		<td COLSPAN=2>
			<table>
				<tr>
					<td>
						<!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-3px;width:280px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object classid=clsid:EA8B6EE6-3DD8-4534-B4BB-27148CF0042B id=gcgd_pyo style="WIDTH:998px;HEIGHT:550px;border:1 solid #777777;display:block;" viewastext>
			 						 <PARAM NAME="DataID"		VALUE="gcds_data">
									 <PARAM NAME="BorderStyle"  VALUE="0">
									 <PARAM NAME="Indwidth"		VALUE="0">
									 <PARAM NAME="Fillarea"		VALUE="true">
									 <PARAM NAME="ColSizing"	VALUE="true">
									 <param name="sortview"     value=left>
								     <PARAM NAME="Format"		VALUE="  
										<FC>ID=CurRow,	         Name=NO,	        width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false Value={CurRow}</FC>
										<C> ID=SIGNET_ID         Name=�ΰ�\\ID,    	width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=SIGNET_SEQ        Name=����,    	    width=30,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = false </C>
										<C> ID=WORK_GB           Name=����\\����,    	width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  EditStyle=Combo,  Data='1:�ű�,2:����,3:����,4:����,5:����'</C>
										<C> ID=MGR_TEAMNM        Name=������,	    	width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<G> Name='����å����'      HeadAlign=Center    HeadBgColor=#B9D4DC
										<C> ID=MAIN_EMPNMK       Name=��,	        width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										<C> ID=SUB_EMPNMK        Name=��,        	width=60,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center, sort = true  </C>
										</G>
										<C> ID=SEND_DATE_CONFIRM Name=�����Ͻ�,	    width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=RECEIVE_DATE  	 Name=�����Ͻ�,	    width=120,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=DISUSE_DATE       Name=�����,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
										<C> ID=DISUSE_REASON     Name=������,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=RECE_DATE         Name=�ݳ���,	        width=70,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=center,	sort = true  MASK='XXXX/XX/XX'</C>
										<C> ID=RECE_REASON       Name=�ݳ�����,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=USEGB             Name=���\\����,	    width=50,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  EditStyle=Combo, Data='1:���,2:����,3:���'</C>
										<C> ID=USE_REMARK        Name=��볻��,	    width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
										<C> ID=ETC 	             Name=����,	        width=100,	HeadBgColor=#B9D4DC, bgcolor=#ffffff, align=left,	sort = true  </C>
									">
								 	</object></comment><script>__ws__(__NSID__);</script> 
								</td>
						  	</tr>
						 </table>
					</td>
			 	</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="24" align="left">��ȸ�Ǽ� : <label id="lbl_search">
		</label></td>
	</tr>	
</table>
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



