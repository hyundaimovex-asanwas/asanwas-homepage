<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ �� �� �� ��	:	�λ�������� - �򰡿�Һ�����(����)
+ ���α׷� ID	:   H060047.html
+ �� �� �� ��	:   
+ �� �� �� ��	: 
+ �� �� �� ��	:   h060047_s1, h060047_s2
------------------------------------------------------------------------------>

<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
get_cookdata();
lfn_init();

/******************************************************************************
	Description : ������ �ε�
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

	  gcem_yymm.text = gcurdate.substring(0,7); 
    //strgcem_yyymm= gcem_yymm.text;
		//txt_empnoh.value = gusrid;
	  //txt_empnmh.value = gusrnm;
		//gcra_divcd.CodeValue = '1';
    //gcem_yymm.ENABLE=true;
	//�����ڵ�
	//ln_Luxecombo_load();  
	//gcra_gubun.CodeValue=1

}

/******************************************************************************
	Description : ��ȸ (�ǰ���������)
******************************************************************************/
function ln_Query(){

    if(gcem_yymm.text=="") {
			alert("��������� �ʼ���ȸ �����Դϴ�.");
		}

    //����
		gcds_data.DataID = "/servlet/Person.h060047_s2?v_str1="+gcem_yymm.text;		//�������
		//prompt("",gcds_data.DataID);
		gcds_data.Reset(); 
}
/******************************************************************************
	Description : ��ȸ (�򰡿�Һ� ����)
******************************************************************************/
function ln_Query2(strYymm,strEmpno){
		gcds_data2.DataID = "/servlet/Person.h060047_s3?v_str1="+strYymm		  //�������
                                                          +"&v_str2="+strEmpno;			//�ǰ����ڻ��
    //prompt("",gcds_data2.DataID);
		gcds_data2.Reset(); 
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
	gcgd_data2.RunExcel('�򰡿�Һ� ��������');
}


/******************************************************************************
	Description : Luxecombo load
******************************************************************************/
function ln_Luxecombo_load(){

}

/******************************************************************************
	Description : Insert Data ����
	                   �����   ������, �ǰ�����,���� ����
******************************************************************************/
function ln_Datasave(){

}

/******************************************************************************
	Description : Check
******************************************************************************/
function ln_Chk(){

}


/******************************************************************************
	Description : �������
******************************************************************************/
function ln_Corcal(){

}

/******************************************************************************
	Description : ������� ã��( ���������� �Ʒ��� )
  parameter   :
******************************************************************************/
function ln_Left(){
  //@@@
	gcds_yymm.DataID = "/servlet/Person.h060047_s4?v_str1=L&v_str2="+gcem_yymm.text;
	gcds_yymm.Reset();

	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_yymm.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}
}

/******************************************************************************
	Description : ������� ã�� ( ���������� ���� ) 
  parameter   :
******************************************************************************/
function ln_Right(){
 //@@@
	gcds_yymm.DataID = "/servlet/Person.h060047_s4?v_str1=R&v_str2="+gcem_yymm.text;
	gcds_yymm.Reset();
	if(gcds_yymm.countrow>0&&gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM")!=""){
		gcem_yymm.text = gcds_yymm.namevalue(gcds_yymm.rowposition,"YYYYMM");
	}
}

</script>


<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!--����-->
<comment id="__NSID__">
  <OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_yymm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript  for=gcds_data event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";

	lbl_search.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
	alert("������ �߻� �߽��ϴ�.");
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  //document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event=OnLoadCompleted(rowcount)>
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	//document.all.LowerFrame.style.visibility="hidden";
	lbl_search2.innerText = "�� ( " + rowcount + " ) ��";
	window.status = " ��ȸ�� �Ϸ� �Ǿ����ϴ�.";
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript"  for=gcgd_data event=OnClick(row,colid)>

  if(row>0){
		ln_Query2(gcds_data.namevalue(row,"EVAYM"),gcds_data.namevalue(row,"EMPNO"));
	}

</script>
 

<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
 

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
    <td background="../../Common/img/com_t_bg.gif"><img src="../img/h060047_head.gif"></td> 
    <td  align="right" style="padding-top:4px;" background="../../Common/img/com_t_bg.gif">
			<img src="../../Common/img/btn/com_b_excel.gif" style="cursor:hand"		onclick="ln_Excel()">
			<img src="../../Common/img/btn/com_b_query.gif" style="cursor:hand"		onclick="ln_Query()">&nbsp;
		</td>
  </tr>

	<tr>
		<td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0" style='width:876px;height:20px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'></td>
				<tr>
						<td width="60"  style="border:0 solid #708090;border-right-width:1px;"     
						bgcolor="#eeeeee"><nobr>&nbsp;�������&nbsp;</nobr></td>
						<td  width="50" style="height:30px;border:0 "><nobr>&nbsp
								<comment id="__NSID__"><object id=gcem_yymm  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	
								style="position:relative; left:1px;top:1px; width:50px; height:20px; font-family:����; font-size:9pt; "> 
								<param name=Alignment	  value=0>
								<param name=Border	      value=true>
								<param name=Numeric	      value=false>
								<param name=Format	      value="YYYY/MM">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								</object></comment><script>__ws__(__NSID__);</script></nobr>
						</td>
						<td style="">
						<img src="../../Common/img/btn/com_btn_left.gif"	 style="cursor:hand;position:relative;top:1px;left:5px" onclick="ln_Left()" >
						<img src="../../Common/img/btn/com_btn_right.gif"  style="cursor:hand;position:relative;top:1px;left:5px" onclick="ln_Right()">
				 </td> 
				</tr>
			</table> 
		</td>
	</tr>

	<tr><td height=3 colspan="2"></td></tr>

	<tr>
		<td colspan=2>
      <table width="876" cellpadding="1" cellspacing="0" border="0">
					<tr> 
						<td style="width:391px;" align=center valign=top>
							<table width="391px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:391px" align=LEFT valign=top  border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data  style="WIDTH: 389px;; HEIGHT: 424px;border:1 solid #777777;z-index:2;" viewastext>
												<param name="DataID"		    value="gcds_data">
												<param name="Editable"      value="false">
												<param name="BorderStyle"   value="0">  
												<param name="Fillarea"		  value="true">
												<param name=ColSelect       value=false>
												<param name=SortView  value="Left">
												<param name=IndWidth        value="0">
												<param name="Format"			  value="  
													<C> Name='�������'	ID=EVAYM		HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center mask='XXXX/XX' </C>
													<G> Name='�ǰ�����' HeadAlign=Center HeadBgColor=#B9D4DC Width=200
													<C> Name='���'	    ID=EMPNO		HeadAlign=Center HeadBgColor=#B9D4DC Width=55  align=center	 sort=true</C>
													<C> Name='����'			ID=EMPNMK  	HeadAlign=Center HeadBgColor=#B9D4DC Width=60  align=left    sort=true</C>
													<C> Name='�Ҽ�'			ID=DEPTNMk 	HeadAlign=Center HeadBgColor=#B9D4DC Width=135 align=left		 sort=true</C>
													<C> Name='����'			ID=PAYGRDNM HeadAlign=Center HeadBgColor=#B9D4DC Width=70  align=left    sort=true</C>
													</G>
											"> 
											</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>

							 <tr>
								<td height="24" border= 1>��ȸ�Ǽ� : <label id="lbl_search"></label></td>
							</tr>	
						 </table>
						</td>

            <td style="width:480px;" align=center valign=top rowspan=2>
							<table width="480px" cellpadding="0" cellspacing="0" border="0">
								<tr> 
									<td style="width:480px" align=LEFT valign=top   border="0">
											<comment id="__NSID__"><OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH: 479px; HEIGHT: 424px;border:1 solid #777777;z-index:2;border-TOP-width:1px;" viewastext>
												<PARAM NAME="DataID"			VALUE="gcds_data2">
												<PARAM NAME="Editable"    VALUE="false">
												<PARAM NAME="BorderStyle" VALUE="0">
												<param name=ViewSummary	  value=1>
												<param name="Fillarea"		VALUE="true">
												<param name=IndWidth      value="0">
												<PARAM NAME="Format"			VALUE="  
												<C> Name='����'			ID=EMPNMK 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	Edit=none  sumbgcolor=#89add6</C>   
												<C> Name='����'     ID=DIVNM		HeadAlign=Center HeadBgColor=#B9D4DC Width=55		align=center	Edit=none  sumbgcolor=#89add6</C> 
												<C> Name='����'			ID=PRTSEQ		HeadAlign=Center HeadBgColor=#B9D4DC Width=38		align=center	Edit=none  sumbgcolor=#89add6</C>
												<C> Name='�򰡿��'	ID=ASKITEM	HeadAlign=Center HeadBgColor=#B9D4DC Width=212  align=left		Edit=none  sumbgcolor=#89add6 SumText='�� ��'</C>
												<C> Name='����'			ID=SCR  		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=right		Edit=none  sumbgcolor=#89add6 SumText=@sum  </C> 
												<C> Name='��'			ID=GRADE 		HeadAlign=Center HeadBgColor=#B9D4DC Width=50		align=center	Edit=none  sumbgcolor=#89add6  </C> 
												">
												</OBJECT></comment><script>__ws__(__NSID__);</script>
									</td>
							 </tr>
							 <tr>
								<td height="24" border= 1>��ȸ�Ǽ� : <label id="lbl_search2"></label></td>
							</tr>	
						 </table>
						</td>
          </tr>
					
			</table>
		</td>
	</tr>
  </table>

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"></iframe> 
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	