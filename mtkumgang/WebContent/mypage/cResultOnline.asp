<%
    '/* ============================================================================== */
    '/* =   PAGE : 지불 요청 및 결과 처리 PAGE                                        = */
    '/* = -------------------------------------------------------------------------- = */
    '/* =   Copyright (c)  2005   KCP Inc.   All Rights Reserverd.                   = */
    '/* ============================================================================== */
%>

<%
c_pay_gubn = request( "c_pay_gubn")	'			<!--공통: 결제수단 -->
c_van_cd = request( "c_van_cd")			'			<!--공통: VAN 구분 -->
c_acct_join_no = request( "c_acct_join_no")     <!-- '가맹점 ID -->
c_terminal_id = request( "c_terminal_id")   '<!--  '단말기번호 아이디 -->
c_return_url = request( "c_return_url")		'    <!--  'return URL -->

s_agree_time = request("s_agree_time")	'지불일시
s_bank_cd = request("s_bank_cd")			'         <!-- 응답: 은행코드-->

    '/* ============================================================================== */
    '/* =   지불 결과                                                                = */
    '/* = -------------------------------------------------------------------------- = */
    req_tx         = request( "req_tx" )                      ' 요청 구분(승인/취소)
    use_pay_method = request( "use_pay_method" )              ' 사용 결제 수단
    bSucc          = request( "bSucc" )                       ' 업체 DB 정상처리 완료 여부
    '/* = -------------------------------------------------------------------------- = */
    res_cd         = request( "s_resp_code" )                      ' 결과 코드
    res_msg        = request( "res_msg" )                     ' 결과 메시지
    '/* = -------------------------------------------------------------------------- = */
    ordr_idxx      = request( "c_pay_manage_no" )                   ' 주문번호
    tno            = request( "s_van_idx_no" )                         ' KCP 거래번호
    good_mny       = request( "c_pay_amt" )                    ' 결제 금액
    good_name      = request( "s_user_key" )                   ' 상품명
    buyr_name      = request( "r_order_nm" )                   ' 구매자명
    buyr_tel1      = request( "s_order_tel_no" )                   ' 구매자 전화번호
    buyr_tel2      = request( "buyr_tel2" )                   ' 구매자 휴대폰번호
    buyr_mail      = request( "s_order_e_mail" )                   ' 구매자 E-Mail
'/* = -------------------------------------------------------------------------- = */
    ' 신용카드
    card_cd        = request( "s_card_cd" )                     ' 카드 코드
    card_name      = request( "s_card_name" )                   ' 카드명
    app_time       = request( "s_app_time" )                    ' 승인시간 (공통)
    app_no         = request( "s_app_no" )                      ' 승인번호
    quota          = request( "s_quota" )                       ' 할부개월
    '/* = -------------------------------------------------------------------------- = */
    ' 계좌이체
    bank_name      = request( "s_bank_nm" )                   ' 은행명
    '/* = -------------------------------------------------------------------------- = */
    ' 가상계좌
    s_order_nm      = request( "s_order_nm" )                   ' 입금계좌 예금주
    s_bank_acct        = request( "s_bank_acct" )                     ' 입금계좌 번호
    '/* = -------------------------------------------------------------------------- = */

    if req_tx = "pay" then
        req_tx_name = "지불"

    elseif req_tx = "mod" then
        req_tx_name = "매입/취소"
    end if

%>
    <html>
    <head>
    <link href="css/sample.css" rel="stylesheet" type="text/css">
    <script language="javascript">
        <!-- 신용카드 영수증 연동 스크립트 -->
        function receiptView(tno)	 //테스트로 결제한 건 영수증이 출력되지 않는다.
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
                        <td align="center">결과 페이지(<%=req_tx_name%>)</td>
                    </tr>
                    <tr>
                        <td bgcolor="CFCFCF" height='2'></td>
                    </tr>
                </table>
<%

    if req_tx = "pay" then                ' 거래 구분 : 승인

        if not bSucc = "false" then       ' 업체 DB 처리 정상

            if res_cd = "0000" then       ' 정상 승인

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>결과코드</td>
                        <td><%=res_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결과 메세지</td>
                        <td><%=res_msg%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>주문번호</td>
                        <td><%=ordr_idxx%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>KCP 거래번호</td>
                        <td><%=tno%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제금액</td>
                        <td><%=good_mny%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>상품명</td>
                        <td><%=good_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>주문자명</td>
                        <td><%=buyr_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>주문자 전화번호</td>
                        <td><%=buyr_tel1%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>주문자 휴대폰번호</td>
                        <td><%=buyr_tel2%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>E-mail</td>
                        <td><%=buyr_mail%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
<%

                if use_pay_method = "100000000000" then            ' 신용카드

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제수단 </td>
                        <td>신용카드</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제카드</td>
                        <td><%=card_cd%> / <%=card_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>승인시간</td>
                        <td><%=app_time%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>승인번호</td>
                        <td><%=app_no%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>할부개월</td>
                        <td><%=quota%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>신용카드 영수증</td>
                        <td><input type="button" name="receiptView" value="영수증 확인" class="box" onClick="javascript:receiptView('<%=tno%>')"></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td colspan="2">※ 영수증 확인은 실제결제의 경우에만 가능합니다.</td>
                    </tr>
                </table>
<%

                elseif use_pay_method = "010000000000" then            ' 계좌이체

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제수단 </td>
                        <td>계좌이체</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>이체은행</td>
                        <td><%=bank_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제 등록 일시</td>
                        <td><%=s_agree_time%></td>
                    </tr>
                </table>
<%

                elseif use_pay_method = "001000000000" then        ' 가상계좌

%>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제수단 </td>
                        <td>가상계좌</td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>입금 은행</td>
                        <td><%=bank_name%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>입금계좌 예금주</td>
                        <td><%=s_order_nm%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>입금계좌 번호</td>
                        <td><%=s_bank_acct%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제 등록 일시</td>
                        <td><%=s_agree_time%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>단말기번호아이디</td>
                        <td><%=c_terminal_id%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>가맹점아이디</td>
                        <td><%=c_acct_join_no%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>밴코드</td>
                        <td><%=c_van_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결제구분</td>
                        <td><%=c_pay_gubn%></td>
                    </tr>
                </table>
<%
                end if

            else                ' 승인 실패

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>결과코드</td>
                        <td><%=res_cd %></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결과 메세지</td>
                        <td><%=res_msg%></td>
                    </tr>
                </table>
<%

            end if

        else                    ' 업체 DB 처리 실패

%>
                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td nowrap>취소 결과코드</td>
                        <td><%=res_cd%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td nowrap>취소 결과 메세지</td>
                        <td><%=res_msg%></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td nowrap>상세메세지</td>
                        <td>
<%
            if res_cd = "0000" then

                                response.write("결제는 정상적으로 이루어졌지만 쇼핑몰에서 결제 결과를 처리하는 중 오류가 발생하여 시스템에서 자동으로 취소 요청을 하였습니다. <br> 쇼핑몰로 전화하여 확인하시기 바랍니다.")

            else

                                response.write("결제는 정상적으로 이루어졌지만 쇼핑몰에서 결제 결과를 처리하는 중 오류가 발생하여 시스템에서 자동으로 취소 요청을 하였으나, <br> <b>취소가 실패 되었습니다.</b><br> 쇼핑몰로 전화하여 확인하시기 바랍니다.")

            end if
%>
                        </td>
                    </tr>
                </table>
<%

        end if

    elseif req_tx = "mod" then       ' 거래 구분 : 취소/매입

%>

                <table width="85%" align="center" border='0' cellpadding='0' cellspacing='1'>
                    <tr>
                        <td>결과코드</td>
                        <td><%=res_cd %></td>
                    </tr>
                    <tr><td colspan="2"><IMG SRC="./img/dot_line.gif" width="100%"></td></tr>
                    <tr>
                        <td>결과 메세지</td>
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
    