<!--
***********************************************************************
* @source      : reta030_ED.jsp
* @description : 퇴직금계산처리(산정 내역 정보를 조회) PAGE
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/11      김학수        최초작성.
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

    String eno_no = request.getParameter("eno_no");
    String occ_cd = (request.getParameter("occ_cd")==null)?"A":request.getParameter("occ_cd");
    String TYPE = request.getParameter("TYPE");

    System.out.println("type  ="+TYPE  );


    /** 외부 XML에서 SQL을 읽어 온다 **/
    String sql = XmlSqlUtils.getSQL("ret", "RETA030_SHR_PAY_RET");

    /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
    Object[] sqlParam = new Object[] {
    };

    /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
    sql = SqlUtils.replaceQuery(sql, sqlParam);

    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
    Object[] bind = new Object[] {
 		eno_no,
 		TYPE
    };
    int i = 0;
    int tot_cnt = 0;
    AbstractDAO aaa= new AbstractDAO("default");
    DynamicValueObject voList = aaa.selectProcessDvo(sql, bind);
    String[][] arr_temp = new String[5][9];
    if ( occ_cd.equals("A") ) {
        arr_temp[0][0] = "기본급";
        arr_temp[0][1] = "직무수당";
        arr_temp[0][2] = "법정수당";
        arr_temp[0][3] = "상여금";
        arr_temp[0][4] = "기타수당";
        arr_temp[0][5] = "기타지불";
    }
    for ( i = 0; i < voList.size(); i++ )
    {
        DynamicValueObject vo = (DynamicValueObject)voList.get(i);

        arr_temp[i+1][0] = vo.getString("BAS_AMT");
        arr_temp[i+1][1] = vo.getString("DUTY_AMT");
        arr_temp[i+1][2] = vo.getString("LAW_AMT");
        arr_temp[i+1][3] = vo.getString("BNS_AMT");
        arr_temp[i+1][4] = vo.getString("OTH_AMT");
        arr_temp[i+1][5] = vo.getString("HOL_AMT");
    }

    extquery hnwExtQuery = new extquery();

    hnwExtQuery.AddField("구분");
    hnwExtQuery.AddField("COL_1");
    hnwExtQuery.AddField("COL_2");
    hnwExtQuery.AddField("COL_3");
    hnwExtQuery.AddField("COL_4");

    hnwExtQuery.SendField(response);

    if (voList.size() > 0)
    {
        for ( i=0; i<6; i++ )
        {
            hnwExtQuery.AddData(arr_temp[0][i]);
            hnwExtQuery.AddData(arr_temp[1][i]);
            hnwExtQuery.AddData(arr_temp[2][i]);
            hnwExtQuery.AddData(arr_temp[3][i]);
            hnwExtQuery.AddData(arr_temp[4][i]);
            
            System.out.println("arr_temp[0]["+i+"]===="+arr_temp[0][i]);
            System.out.println("arr_temp[1]["+i+"]===="+arr_temp[1][i]);
            System.out.println("arr_temp[2]["+i+"]===="+arr_temp[2][i]);
            System.out.println("arr_temp[3]["+i+"]===="+arr_temp[3][i]);
            System.out.println("arr_temp[4]["+i+"]===="+arr_temp[4][i]);

            hnwExtQuery.SendData(response);
        }
    } else {
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");
            hnwExtQuery.AddData("");

            hnwExtQuery.SendData(response);
    }

%>