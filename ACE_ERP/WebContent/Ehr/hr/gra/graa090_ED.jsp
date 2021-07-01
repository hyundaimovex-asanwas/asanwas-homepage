<!--
***********************************************************************
* @source      : graa090_ED.jsp
* @description : 정기승급 현황 PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/06      김학수        최초작성.
***********************************************************************
-->
<%@ page
  contentType="text/html; charset=euc-kr"
  import="javax.naming.*,
          elsoft.extquery.*"
%>
<%@page import="com.shift.gef.support.vo.* "%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"%>
<%@page import ="com.shift.gef.support.vo.DynamicValueObject" %>
<%@page import ="com.shift.gef.dbms.utility.XmlSqlUtils"  %>
<%@page import ="com.shift.gef.dbms.utility.SqlUtils"%>
<%@page import=" com.shift.gef.enterprise.dao.AbstractDAO"   %>

<%
    String REC_YMD_SHR = request.getParameter("REC_YMD_SHR");

    String str_ymd  = "";
    String str_ymd2 = "";
    String end_ymd  = "";

    int rec_y_str     = Integer.parseInt(REC_YMD_SHR)-5;
    String rec_y_str2 = Integer.toString(rec_y_str);

    str_ymd  = REC_YMD_SHR + "0101";
    str_ymd2 = REC_YMD_SHR + "0301";
    end_ymd  = REC_YMD_SHR + "1201";

    int i = 0;

    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("gra", "GRAA090_SHR");

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
    	  REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
        , REC_YMD_SHR
    };

    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("직급");
    hnwExtQuery.AddField("인원");
    hnwExtQuery.AddField("계");
    hnwExtQuery.AddField("정상승급");
    hnwExtQuery.AddField("특별승급");
    hnwExtQuery.AddField("계1");
    hnwExtQuery.AddField("승진");
    hnwExtQuery.AddField("중도입사");
    hnwExtQuery.AddField("휴직");
    hnwExtQuery.AddField("기타사유");
    hnwExtQuery.AddField("고과불량");

    hnwExtQuery.SendField(response);

//    System.out.println("voList.size()="+voList.size());
    if (voList.size() > 0)
    {
        for ( i=0; i<voList.size(); i++ )
        {
            DynamicValueObject vo = (DynamicValueObject)voList.get(i);

            hnwExtQuery.AddData(vo.getString("COMM_NM"));
            hnwExtQuery.AddData(vo.getString("TOT_CNT"));
            hnwExtQuery.AddData(vo.getString("T1"));
            hnwExtQuery.AddData(vo.getString("B_CNT"));
            hnwExtQuery.AddData(vo.getString("C_CNT"));
            hnwExtQuery.AddData(vo.getString("T2"));
            hnwExtQuery.AddData(vo.getString("D_CNT"));
            hnwExtQuery.AddData(vo.getString("E_CNT"));
            hnwExtQuery.AddData(vo.getString("F_CNT"));
            hnwExtQuery.AddData(vo.getString("G_CNT"));
            hnwExtQuery.AddData(vo.getString("H_CNT"));

            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>