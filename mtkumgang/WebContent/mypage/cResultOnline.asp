<%
    '/* ============================================================================== */
    '/* =   PAGE : ���� ��û �� ��� ó�� PAGE                                        = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   Copyright (c)  2005   KCP Inc.   All Rights Reserverd.                   = */
    '/* ============================================================================== */
%>

<%
c_pay_gubn = request( "c_pay_gubn")	'			<!--����: �������� -->
c_van_cd = request( "c_van_cd")			'			<!--����: VAN ���� -->
c_acct_join_no = request( "c_acct_join_no")     <!-- '������ ID -->
c_terminal_id = request( "c_terminal_id")   '<!--  '�ܸ����ȣ ���̵� -->
c_return_url = request( "c_return_url")		'    <!--  'return URL -->

s_agree_time = request("s_agree_time")	'�����Ͻ�
s_bank_cd = request("s_bank_cd")			'         <!-- ����: �����ڵ�-->

    '/* ============================================================================== */
    '/* =   ���� ���                                                                = */
    '/* = -------------------------------------------------------------------------- = */
    req_tx         = request( "req_tx" )                      ' ��û ����(����/���)
    use_pay_method = request( "use_pay_method" )              ' ��� ���� ����
    bSucc          = request( "bSucc" )                       ' ��ü DB ����ó�� �Ϸ� ����
    '/* = -------------------------------------------------------------------------- = */
    res_cd         = request( "s_resp_code" )                      ' ��� �ڵ�
    res_msg        = request( "res_msg" )                     ' ��� �޽���
    '/* = -------------------------------------------------------------------------- = */
    ordr_idxx      = request( "c_pay_manage_no" )                   ' �ֹ���ȣ
    tno            = request( "s_van_idx_no" )                         ' KCP �ŷ���ȣ
    good_mny       = request( "c_pay_amt" )                    ' ���� �ݾ�
    good_name      = request( "s_user_key" )                   ' ��ǰ��
    buyr_name      = request( "r_order_nm" )                   ' �����ڸ�
    buyr_tel1      = request( "s_order_tel_no" )                   ' ������ ��ȭ��ȣ
    buyr_tel2      = request( "buyr_tel2" )                   ' ������ �޴�����ȣ
    buyr_mail      = request( "s_order_e_mail" )                   ' ������ E-Mail
'/* = -------------------------------------------------------------------------- = */
    ' �ſ�ī��
    card_cd        = request( "s_card_cd" )                     ' ī�� �ڵ�
    card_name      = request( "s_card_name" )                   ' ī���
    app_time       = request( "s_app_time" )                    ' ���νð� (����)
    app_no         = request( "s_app_no" )                      ' ���ι�ȣ
    quota          = request( "s_quota" )                       ' �Һΰ���
    '/* = -------------------------------------------------------------------------- = */
    ' ������ü
    bank_name      = request( "s_bank_nm" )                   ' �����
    '/* = -------------------------------------------------------------------------- = */
    ' �������
    s_order_nm      = request( "s_order_nm" )                   ' �Աݰ��� ������
    s_bank_acct        = request( "s_bank_acct" )                     ' �Աݰ��� ��ȣ
    '/* = -------------------------------------------------------------------------- = */

    if req_tx = "pay" then
        req_tx_name = "����"

    elseif req_tx = "mod" then
        req_tx_name = "����/���"
    end if

%>
    <html>
    <head>
    <link href="css/sample.css" rel="stylesheet" type="text/css">
    <script language="javascript">
        <!-- �ſ�ī�� ������ ���� ��ũ��Ʈ -->
        function receiptView(tno)	 //�׽�Ʈ�� ������ �� �������� ��µ��� �ʴ´�.
        {
            receiptWin = "http://admin.kcp.co.kr/Modules/Sale/Card/ADSA_CARD_BILL_Receipt.jsp?c_trade_no=" + tno
            window.open(receiptWin , "" , "width=420, height=670")
        } 
    </script>
    </head>
    <body>
    <center>
    <table border='0' cellpadding='0' cellspacing='1' width='500' align='center'>
        <tr>
            <td align="left" height="25"><img src="./img/KcpLogo.jpg" border="0" width="65" height="50"></td>
            <td align='right' class="txt_main">KCP Online Payment System [AX_HUB ASP Version]</td>
        </tr>
        <tr>
            <td colspan="2">
                <br>
                <table width="90%" align="center">
                    <tr>
                        <td bgcolor="CFCFCF" height='2'></td>
                    </tr>
                    <tr>
                        <td align="center">��� ������(<%=req_tx_name%>)</td>
                    </tr>
                    <tr>
                        <td bgcolor="CFCFCF" height='2'></td>
                    </tr>
                </table>
<%

    if req_tx = "pay" then                ' �ŷ� ���� : ����

        if not bSucc = "false" then       ' ��ü DB ó�� ����

            if res_cd = "0000" then       ' ���� ����

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>����ڵ�</td>
                        <td><%=res_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��� �޼���</td>
                        <td><%=res_msg%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ֹ���ȣ</td>
                        <td><%=ordr_idxx%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>KCP �ŷ���ȣ</td>
                        <td><%=tno%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�����ݾ�</td>
                        <td><%=good_mny%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��ǰ��</td>
                        <td><%=good_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ֹ��ڸ�</td>
                        <td><%=buyr_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ֹ��� ��ȭ��ȣ</td>
                        <td><%=buyr_tel1%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ֹ��� �޴�����ȣ</td>
                        <td><%=buyr_tel2%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>E-mail</td>
                        <td><%=buyr_mail%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
<%

                if use_pay_method = "100000000000" then            ' �ſ�ī��

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�������� </td>
                        <td>�ſ�ī��</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>����ī��</td>
                        <td><%=card_cd%> / <%=card_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���νð�</td>
                        <td><%=app_time%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���ι�ȣ</td>
                        <td><%=app_no%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�Һΰ���</td>
                        <td><%=quota%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ſ�ī�� ������</td>
                        <td><input type="button" name="receiptView" value="������ Ȯ��" class="box" onClick="javascript:receiptView('<%=tno%>')"></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td colspan="2">�� ������ Ȯ���� ���������� ��쿡�� �����մϴ�.</td>
                    </tr>
                </table>
<%

                elseif use_pay_method = "010000000000" then            ' ������ü

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�������� </td>
                        <td>������ü</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��ü����</td>
                        <td><%=bank_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���� ��� �Ͻ�</td>
                        <td><%=s_agree_time%></td>
                    </tr>
                </table>
<%

                elseif use_pay_method = "001000000000" then        ' �������

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�������� </td>
                        <td>�������</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�Ա� ����</td>
                        <td><%=bank_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�Աݰ��� ������</td>
                        <td><%=s_order_nm%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�Աݰ��� ��ȣ</td>
                        <td><%=s_bank_acct%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���� ��� �Ͻ�</td>
                        <td><%=s_agree_time%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>�ܸ����ȣ���̵�</td>
                        <td><%=c_terminal_id%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���������̵�</td>
                        <td><%=c_acct_join_no%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>���ڵ�</td>
                        <td><%=c_van_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��������</td>
                        <td><%=c_pay_gubn%></td>
                    </tr>
                </table>
<%
                end if

            else                ' ���� ����

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>����ڵ�</td>
                        <td><%=res_cd %></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��� �޼���</td>
                        <td><%=res_msg%></td>
                    </tr>
                </table>
<%

            end if

        else                    ' ��ü DB ó�� ����

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td nowrap>��� ����ڵ�</td>
                        <td><%=res_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td nowrap>��� ��� �޼���</td>
                        <td><%=res_msg%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td nowrap>�󼼸޼���</td>
                        <td>
<%
            if res_cd = "0000" then

                                response.write("������ ���������� �̷�������� ���θ����� ���� ����� ó���ϴ� �� ������ �߻��Ͽ� �ý��ۿ��� �ڵ����� ��� ��û�� �Ͽ����ϴ�. <br> ���θ��� ��ȭ�Ͽ� Ȯ���Ͻñ� �ٶ��ϴ�.")

            else

                                response.write("������ ���������� �̷�������� ���θ����� ���� ����� ó���ϴ� �� ������ �߻��Ͽ� �ý��ۿ��� �ڵ����� ��� ��û�� �Ͽ�����, <br> <b>��Ұ� ���� �Ǿ����ϴ�.</b><br> ���θ��� ��ȭ�Ͽ� Ȯ���Ͻñ� �ٶ��ϴ�.")

            end if
%>
                        </td>
                    </tr>
                </table>
<%

        end if

    elseif req_tx = "mod" then       ' �ŷ� ���� : ���/����

%>

                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>����ڵ�</td>
                        <td><%=res_cd %></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>��� �޼���</td>
                        <td><%=res_msg%></td>
                    </tr>
                </table>
<%

    end if

%>
                <table width="90%" align="center">
                    <tr>
                        <td bgcolor="CFCFCF" height='2'></td>
                    </tr>
                    <tr>
                        <td height='2'>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td bgcolor="CFCFCF" height='3' colspan='2'></td>
        </tr>
    </table>
    </center>
    </body>
    </html>
    