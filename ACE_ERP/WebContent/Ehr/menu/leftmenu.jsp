<!--
*****************************************************
* @source       : leftmenu.jsp
* @description : LEFT PAGE :: left menu
*****************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------
* 2006/08/29      ������        �����ۼ�.
* 2006/09/06      �輮��        ���ϼ���
*****************************************************
-->

<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ include file="/common/sessionCheck.jsp"%>
<%
String SESSION_ROLE_CD = box.get("SESSION_ROLE_CD");
%>
<!-- Potential�� ����� ����ϱ� ���ؼ��� �ݵ�� �������� ��� �κп� ���ǰ� �Ǿ��� �־�� �Ѵ�. -->
<script>var frame; try {frame = window.external.GetFrame(window);}catch(e){alert(window.name);alert("frame �ʱ�ȭ ����");}</script>

<html>
<head>
<title>left menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link href="/css/general.css" rel="stylesheet" type="text/css">

<style TYPE="text/css">
.TextGray
{font-size:9pt;color:6D6E71;fontfamily:����,����;font-weight:bold;}
</style>

<script language=javascript src="/common/common.js"></script>
<script language=javascript src="/common/input.js"></script>

<!--
******************************************************
* �ڹٽ�ũ��Ʈ �Լ� ����κ�
******************************************************
-->
<script language="javascript" >

    /*****************************
	* MDI Control ���� ���� ���� *
	*****************************/
	var curFrame = opener.frame.Provider("body");    //����Ʈ ����â����(1������ȭ��)
	var arg1 = '';
	var arg2 = '';
	var arg3 = '';
	var arg4 = '';
	var arg5 = '';
	var arg6 = '';
	var arg7 = '';
	var arg8 = '';
	var arg9 = '';
	var arg10 = '';

	function fnc_OnLoadProcess(){
		/* �Ϲݻ����, ������, �μ����ΰ�� */
		if("1040" == "<%=SESSION_ROLE_CD%>" || "2021" == "<%=SESSION_ROLE_CD%>" || "2022" == "<%=SESSION_ROLE_CD%>"){

			fnc_ChangeLeftMenu(1);
			fnc_FavoritesReSet();
		}
	}

	/**********************************************
	* ���õ� Form�� �̹� Loading �Ǿ� �ִ��� üũ *
	**********************************************/
	function fnc_LoadingCheck(id){

		curFrame.ChildWndCollection();

		//���� Loading�Ǿ� �ִ� ȭ���� ���� ��ŭ ���鼭 �ش� ID
		for(i = 0 ; i < curFrame.CollectionLength ; i++)
		{
		   if(curFrame.item(i).FrameID==id){
			return true;
		   }
		}
		return false;
	}

	/***********************************************
	* Ư�� ���� ����� ó�� �ؾ� �� ���� ���� ��� *
	***********************************************/
	function fnc_FormClose(Form_ID) {

		//alert("�����ϰ��� �ϴ� â �̸��� : " + Form_ID);

	}

	/***************************************
	* Ư�� ���� Active or DeActive �� ��� *
	****************************************/
	function fnc_FormEvent(Form_ID,Event_NM )
	{
		//alert(Form_ID + ":" + Event_NM);

	}

	curFrame.SetEvent("Onclose", fnc_FormClose);
	curFrame.SetEvent("onwinstat", fnc_FormEvent);

	/********************************
	* �̹� Load �Ǿ� �ִ� Form Show *
	********************************/
	function show_top(id) {

        curFrame.Provider(id).FrameShow("maximize");

	}

	/*************
	* Menu Reset *
	*************/
	function fnc_MenuReSet(Arg1,Arg2,Arg3,Arg4,Arg5,Arg6,Arg7,Arg8,Arg9,Arg10){

		//�ϴ� �޴� Tree�� Clear �Ѵ�.
		tb_DataSet.ClearData();
		arg1 = Arg1;
		arg2 = Arg2;
		arg3 = Arg3;
		arg4 = Arg4;
		arg5 = Arg5;
		arg6 = Arg6;
		arg7 = Arg7;
		arg8 = Arg8;
		arg9 = Arg9;
		arg10 = Arg10;

		var GUBUN  = '<%=box.get("SESSION_GUBUN")%>';
        var ENO_NO = '<%=box.get("SESSION_ENONO")%>';

        //Login ������� ���� Role ������ ���� �´�.
		tb_DataSet2.DataId="/servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&ENO_NO="+ENO_NO;
		tb_DataSet2.Reset();
		fnc_ChangeLeftMenu(0);

	}

	//���ã��
	function fnc_FavoritesReSet(){

		//�ϴ� �޴� Tree�� Clear �Ѵ�.
		tb_DataSet_Fav.ClearData();
		arg1 = "fav";
		arg2 = "";
		arg3 = "";
		arg4 = "";
		arg5 = "";
		arg6 = "";
		arg7 = "";
		arg8 = "";
		arg9 = "";
		arg10 = "";

		var GUBUN  = '<%=box.get("SESSION_GUBUN")%>';
        var ENO_NO = '<%=box.get("SESSION_ENONO")%>';

        //Login ������� ���� Role ������ ���� �´�.
		tb_DataSet_Fav2.DataId="/servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_00&GUBUN="+GUBUN+"&ENO_NO="+ENO_NO;
		tb_DataSet_Fav2.Reset();

	}

    /**
     * ���ã��� ��з� �޴����� ���ú����ش�.
     * @param idx - (0: �޴���, 1: ���ã��)
     */
    function fnc_ChangeLeftMenu(idx) {
        var btnMenuMnList   = new Array("tab_btnmenu01" , "tab_btnmenu02"   );
        var leftMenuMnList  = new Array("tab_leftmenu01", "tab_leftmenu02"  );

        fnc_ShowHiddenLayer(btnMenuMnList   , btnMenuMnList[idx]    );
        fnc_ShowHiddenLayer(leftMenuMnList  , leftMenuMnList[idx]   );
    }
</script>



</head>

<!--
**************************************************************
* ���콺 ������Ʈ ���� �� �̺�Ʈ (Ʈ������, �����ͼ�) : (Visible : X)
**************************************************************
-->

<!-- ���� �޴� ������ ���Ǵ� �����ͼ� -->
<comment id="__NSID__">
<object id=tb_DataSet classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- ���� �޴� ������ ���Ǵ� �����ͼ� (����ڱ���ID ��Ƶ�) -->
<comment id="__NSID__">
<object id=tb_DataSet2 classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- ���� �޴� ���ã�⿡ ���Ǵ� �����ͼ� -->
<comment id="__NSID__">
<object id=tb_DataSet_Fav classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- ���� �޴� ���ã�⿡ ���Ǵ� �����ͼ� (����ڱ���ID ��Ƶ�) -->
<comment id="__NSID__">
<object id=tb_DataSet_Fav2 classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

<!-- ���α׷� ��� �α� ������ ���� �����ͼ� -->
<comment id="__NSID__">
<object id=dsT_CM_ACCESSLOG classid=CLSID:2506B38B-0FF7-4249-BA3E-8BC1DC399FBB>
	<param name=Syncload	value="true">
</object>
</comment><SCRIPT>__ShowEmbedObject(__NSID__);</SCRIPT>

    <!--*************************************
    *                                       *
    *  Component���� �߻��ϴ� Event ó����  *
    *                                       *
    **************************************-->

	<!-----------------------------------------------------+
	| �α��� ������� role ������ ���������� ���� �Դ���   |
	+------------------------------------------------------>
	<script language=JavaScript for="tb_DataSet2" event=OnLoadCompleted(iCount)>

		var GUBUN   = '<%=box.get("SESSION_GUBUN")%>';
		var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';
		var COMM_CD = tb_DataSet2.NameValue(1, "COMM_CD");
		var ROLE_CD = tb_DataSet2.NameValue(1, "ROLE_CD");

		//����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
		tb_DataSet.DataId="/servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD+"&MENU_ID1="+arg1+"&MENU_ID2="+arg2+"&MENU_ID3="+arg3+"&MENU_ID4="+arg4+"&MENU_ID5="+arg5+"&MENU_ID6="+arg6+"&MENU_ID7="+arg7+"&MENU_ID8="+arg8+"&MENU_ID9="+arg9+"&MENU_ID10="+arg10;
		tb_DataSet.Reset();

        var arg1_msg;

        if      (arg1 == 'pir') arg1_msg = "�λ����";
        else if (arg1 == 'gun') arg1_msg = "���°���";
        else if (arg1 == 'edu') arg1_msg = "��������";
        else if (arg1 == 'vlu') arg1_msg = "�λ���";
        else if (arg1 == 'sag') arg1_msg = "�������";
        else if (arg1 == 'wel') arg1_msg = "�����Ļ�";
        else if (arg1 == 'ret') arg1_msg = "���꼼��";
        else if (arg1 == 'mis') arg1_msg = "�濵����";
        else if (arg1 == 'law') arg1_msg = "��������";
        else if (arg1 == 'cod') arg1_msg = "��������";
        else arg1_msg = "";

        if(arg1_msg != "") {
            document.getElementById("tab_btn01").innerText = arg1_msg;
            document.getElementById("tab_btn02").innerText = arg1_msg;
        }
	</script>

	<script language=JavaScript for="tb_DataSet_Fav2" event=OnLoadCompleted(iCount)>

		var GUBUN   = '<%=box.get("SESSION_GUBUN")%>';
		var ENO_NO  = '<%=box.get("SESSION_ENONO")%>';
		var COMM_CD = tb_DataSet_Fav2.NameValue(1, "COMM_CD");
		var ROLE_CD = tb_DataSet_Fav2.NameValue(1, "ROLE_CD");

		//����� ���� üũ�� ���� �ش� ������� Role ID�� ������ �� ���������� �����Դٸ� �޴� Tree�� Display�Ѵ�.
		tb_DataSet_Fav.DataId="/servlet/GauceChannelSVL?cmd=common.menu.userauth.cmd.USERAUTHCMD&S_MODE=SHR_01&GUBUN="+GUBUN+"&ENO_NO="+ENO_NO+"&COMM_CD="+COMM_CD+"&ROLE_CD="+ROLE_CD+"&MENU_ID1="+arg1+"&MENU_ID2="+arg2+"&MENU_ID3="+arg3+"&MENU_ID4="+arg4+"&MENU_ID5="+arg5+"&MENU_ID6="+arg6+"&MENU_ID7="+arg7+"&MENU_ID8="+arg8+"&MENU_ID9="+arg9+"&MENU_ID10="+arg10;
		tb_DataSet_Fav.Reset();
	</script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<script language="javascript"  for="tb_DataSet2" event="OnLoadError()">
		cfErrorMsg(this);
	</script>

	<script language="javascript"  for="tb_DataSet_Fav2" event="OnLoadError()">
		cfErrorMsg(this);
	</script>

	<!-----------------------------------------------------+
	| �α��� ������� role ������ ���������� ���� �Դ���   |
	+------------------------------------------------------>
	<script language=JavaScript for="tb_DataSet" event=OnLoadCompleted(iCount)>
		if (iCount < 1)    {
			alert("���ϴ� �ش� �޴� �׷쿡 ��� ������ ���α׷��� �����ϴ�!");
		}
	</script>

	<!-----------------------------------------------------+
    | �����͸� ��ȸ �� ������ �߻��Ͽ��� �� ó���ϴ� ����  |
    +------------------------------------------------------>
	<script language="javascript"  for="tb_DataSet" event="OnLoadError()">
		cfErrorMsg(this);
	</script>

    <script language=JavaScript for=tb_TreeView event=OnItemClick()>

        var MENU_ID      = tb_DataSet.NameValue(tb_DataSet.RowPosition,"MENU_ID");          //�޴� ID
        var FORM_ID      = tb_DataSet.NameValue(tb_DataSet.RowPosition,"FORM_ID");          //JSP Form(File) ID
        var MENU_NM      = tb_DataSet.NameValue(tb_DataSet.RowPosition,"MENU_NM")+"("+ FORM_ID + ")";   //�޴���
        var MENU_FLD     = tb_DataSet.NameValue(tb_DataSet.RowPosition,"MENU_FLD");         //�޴� ����
        var MENU_GBN     = tb_DataSet.NameValue(tb_DataSet.RowPosition,"MENU_GBN");         //�޴�����(f:Form, m:Menu p:Popup)
        var MENU_URL     = MENU_FLD + FORM_ID + ".jsp";                                     //MENU URL

        //������ Form�� �ƴϸ� Exit Sub
        if (MENU_GBN !="f") return false;

        if       (MENU_ID == "buta200") {window.open('http://www.hdasantour.com/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta201") {window.open('http://www.korail.com/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta202") {window.open('http://www.exterminal.co.kr/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta203") {window.open('http://www.easyticket.co.kr/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else{
            //�̹� Open�� Form�� �ִٸ� �ش� Form�� Ȱ��ȭ ��Ų��.
            if (fnc_LoadingCheck(MENU_ID)) {

                show_top(MENU_ID);

            }else{

                curFrame.ChildWndCollection();
                if (curFrame.CollectionLength > 20) {
                    alert('Ȱ��ȭ �Ǿ� �ִ� â�� �����ϴ�. ���� ȭ���� �ݰ� �۾��ϼ���!');
                    return false;
                }

                //���α׷� ��� �α� ����
                if("<%=box.get("SESSION_ENONO")%>" != "2001039"){
	               dsT_CM_ACCESSLOG.DataId="/servlet/GauceChannelSVL?cmd=common.menu.accesslog.cmd.ACCESSLOGCMD&S_MODE=SAV&PROG_ID="+FORM_ID+"&ACT_GBN=O";
	               dsT_CM_ACCESSLOG.Reset();
                }

                //�ش� ȭ���� Load(Show)
                curFrame.CreateFrame(MENU_ID, MENU_URL, MENU_NM, 0, 0, 860, 550, "window", 0,"showmaximized", true);
                curFrame.Provider(MENU_ID).ShowMaxCaption=false;     //Title Bar Hidden

            }

        }
    </script>

    <!-- ���ã�� �̺�Ʈ -->
    <script language=JavaScript for=tb_TreeView_Fav event=OnItemClick()>
        var MENU_ID      = tb_DataSet_Fav.NameValue(tb_DataSet_Fav.RowPosition,"MENU_ID");          //�޴� ID
        var FORM_ID      = tb_DataSet_Fav.NameValue(tb_DataSet_Fav.RowPosition,"FORM_ID");          //JSP Form(File) ID
        var MENU_NM      = tb_DataSet_Fav.NameValue(tb_DataSet_Fav.RowPosition,"MENU_NM")+"("+ FORM_ID + ")";   //�޴���
        var MENU_FLD     = tb_DataSet_Fav.NameValue(tb_DataSet_Fav.RowPosition,"MENU_FLD");         //�޴� ����
        var MENU_GBN     = tb_DataSet_Fav.NameValue(tb_DataSet_Fav.RowPosition,"MENU_GBN");         //�޴�����(f:Form, m:Menu p:Popup)
        var MENU_URL     = MENU_FLD + FORM_ID + ".jsp";                                             //MENU URL

        //������ Form�� �ƴϸ� Exit Sub
        if (MENU_GBN !="f") return false;


        //�̹� Open�� Form�� �ִٸ� �ش� Form�� Ȱ��ȭ ��Ų��.
		if       (MENU_ID == "buta200") {window.open('http://www.hdasantour.com/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta201") {window.open('http://www.korail.com/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta202") {window.open('http://www.exterminal.co.kr/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else if (MENU_ID == "buta203") {window.open('http://www.easyticket.co.kr/','imgPopupwin','width=1024,height=768,top=0,left=0,scrollbars=yes,resizable=yes');
        }else{
			if (fnc_LoadingCheck(MENU_ID)) {

				show_top(MENU_ID);

			}else{

				curFrame.ChildWndCollection();
				if (curFrame.CollectionLength > 20) {
					alert('Ȱ��ȭ �Ǿ� �ִ� â�� �����ϴ�. ���� ȭ���� �ݰ� �۾��ϼ���!');
					return false;
				}

				//���α׷� ��� �α� ����
				if("<%=box.get("SESSION_ENONO")%>" != "90000160"){
					dsT_CM_ACCESSLOG.DataId="/servlet/GauceChannelSVL?cmd=common.menu.accesslog.cmd.ACCESSLOGCMD&S_MODE=SAV&PROG_ID="+FORM_ID+"&ACT_GBN=O";
					dsT_CM_ACCESSLOG.Reset();
				}

				//�ش� ȭ���� Load(Show)
				curFrame.CreateFrame(MENU_ID, MENU_URL, MENU_NM, 0, 0, 860, 550, "window", 0,"showmaximized", true);
				curFrame.Provider(MENU_ID).ShowMaxCaption=false;     //Title Bar Hidden
			}
        }
    </script>
<!--
**************************************************************
* BODY START
**************************************************************
-->
<body leftmargin="0" topmargin="0" style="background-color :#E7EEDD" onload="fnc_OnLoadProcess();" scroll="no">
<table cellspacing="0" cellpadding="0" border="0" height="100%" width="100%" style="table-layout:fixed; ">
	<tr height="1"><td bgcolor="#FFFFFF"></td></tr>
    <tr>
        <td height="25" bgcolor="#FFFFFF">


<!-- ��ư�� -->
            <div class=page id="tab_btnmenu01" style="" >
                <!--�޴� over -->
                <table width="170" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td style="padding:5 0 0 0"><table width="170" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td id="tab_btn02" width="85" height="25" align="center" valign="middle" bgcolor="#FFFFFF" style="BACKGROUND-POSITION: Left; BACKGROUND-IMAGE: url(/images/left/tabLeft.gif); BACKGROUND-REPEAT: no-repeat;padding:3 0 0 0;" class="TextGray" onclick="fnc_ChangeLeftMenu(0)" style="cursor:hand;">HRMS</td>
                          <td align="center" valign="middle" bgcolor="#FFFFFF" style="BACKGROUND-POSITION: left; BACKGROUND-IMAGE: url(/images/left/tabRightOver.gif); BACKGROUND-REPEAT: no-repeat;padding:3 0 0 0" onclick="fnc_ChangeLeftMenu(1); fnc_FavoritesReSet()" style="cursor:hand;">���ã��</td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
            </div>

            <div class=page id="tab_btnmenu02" style="position:absolute; visibility:hidden" >
                <!--���ã��over-->
                <table width="170" border="0" cellspacing="0" cellpadding="0">
                  <tr>
                    <td style="padding:5 0 0 0"><table width="170" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td id="tab_btn01" width="85" height="25" align="center" valign="middle" bgcolor="#FFFFFF" style="BACKGROUND-POSITION: Left; BACKGROUND-IMAGE: url(/images/left/tabLeftOver.gif); BACKGROUND-REPEAT: no-repeat;padding:3 0 0 0" onclick="fnc_ChangeLeftMenu(0)" style="cursor:hand;">HRMS</td>
                          <td align="center" valign="middle" bgcolor="#FFFFFF" style="BACKGROUND-POSITION: left; BACKGROUND-IMAGE: url(/images/left/tabRight.gif); BACKGROUND-REPEAT: no-repeat;padding:3 0 0 0" class="TextGray" onclick="fnc_ChangeLeftMenu(1); fnc_FavoritesReSet()" style="cursor:hand;">���ã��</td>
                        </tr>
                      </table></td>
                  </tr>
                </table>
            </div>
<!-- ��ư�� -->


        </td>
    </tr>
	<tr height="35">
		<td align="center" class="info"><img src="/images/common/infoIcon.gif" width="11" height="13" align="absmiddle">
      <strong><%=box.get("SESSION_ENONM")%></strong>�� �ȳ��ϼ���.</td>
	</tr>
	<tr height="5">
		<td>
		</td>
	</tr>
	<tr height="">
		<td>
            <!-- ���� �޴� Ʈ�� �� -->
            <div class=page id="tab_leftmenu01"  style="" >
    			<comment id="__NSID__">
    			<object id=tb_TreeView classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="height:100%; width:170">
    				<param name=DataID		value="tb_DataSet">
    				<param name=TextColumn	value="MENU_NM">
    				<param name=LevelColumn	value="MENU_LBL">
    				<param name=ExpandLevel	value="0">
    				<param name=BorderStyle  value="0">
    				<param name=UseImage      value="false">
    			</object>
    			</comment><script> __ShowEmbedObject(__NSID__); </script>
            </div>

            <!-- ���ã�� -->
            <div class=page id="tab_leftmenu02" style="position:absolute; visibility:hidden" >
                <comment id="__NSID__">
                <object id=tb_TreeView_Fav classid=CLSID:6DD1CE9F-1722-46F0-AF93-B2BC58383CD2 style="height:100%; width:170">
                    <param name=DataID      value="tb_DataSet_Fav">
                    <param name=TextColumn  value="MENU_NM">
                    <param name=LevelColumn value="MENU_LBL">
                    <param name=ExpandLevel value="1">
                    <param name=BorderStyle  value="0">
                    <param name=UseImage      value="false">
                </object>
                </comment><script> __ShowEmbedObject(__NSID__); </script>
            </div>
		</td>
	</tr>
	<tr height="70">
		<td>
		</td>
	</tr>
</table>

</body>

</html>