<!--
***********************************************************************
* @source      : taxa150_ED.jsp
* @description : �ֹμ�Ư��¡������(�޿�)
***********************************************************************
* DATE            AUTHOR        DESCRIPTION
*----------------------------------------------------------------------
* 2007/04/03      �漮ȣ        �����ۼ�.
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
	DynamicValueObject voList = null;
	DynamicValueObject vo = null;

	String PIS_YYMM = request.getParameter("PIS_YYMM");
	String PIS_YY = request.getParameter("PIS_YYMM").substring(0,4);
	String PIS_MM = request.getParameter("PIS_YYMM").substring(4,6);
	String DPT_CD = request.getParameter("DPT_CD");

	String dpt_nm = null;
	String dpt_seq = null;
	String key = ""; //Ű��

	int eno_cnt = 0;

	int eno_mid = 0;

	int eno_tot_1 = 0;
	int eno_tot_2 = 0;
	int eno_tot_3 = 0;


	int tot_num = 0;


	//��
	long incm_tax = 0;
	long citi_tax = 0;

	//�Ұ�
	long incm_mid = 0;
	long citi_mid = 0;

	//����
	long incm_tot_1 = 0;
	long incm_tot_2 = 0;
	long incm_tot_3 = 0;

	long citi_tot_1 = 0;
	long citi_tot_2 = 0;
	long citi_tot_3 = 0;



	String sql = XmlSqlUtils.getSQL("tax2", "TAXA131_PRT1");
	  Object[] bind = new Object[]{
			PIS_YY,
    		PIS_MM,
    		PIS_YYMM,
    		PIS_YYMM,
    		DPT_CD
    };

	AbstractDAO aaa= new AbstractDAO("default");
    voList = aaa.selectProcessDvo(sql, bind);

    extquery hnwExtQuery = new extquery();


    hnwExtQuery.AddField("DPT_NM");
    hnwExtQuery.AddField("DPT_SEQ");
    hnwExtQuery.AddField("GBN");
    hnwExtQuery.AddField("ENO_NO");
    hnwExtQuery.AddField("INCM_TAX");
    hnwExtQuery.AddField("CITI_TAX");

    hnwExtQuery.AddField("BIGO");
    hnwExtQuery.AddField("ENO_NM");
    hnwExtQuery.AddField("NUM");



    hnwExtQuery.SendField(response);



    int i=0;

    if (voList.size() > 0)
    {

        while(true) {

            vo = (DynamicValueObject)voList.get(i);

            if(dpt_nm != null) {


				if(dpt_nm.equals(vo.getString("DPT_NM"))) {

					//�踦 ����ô�. ù��° ���� �μ��� ���� �ڵ尡 �ٸ� ���
		            if(!key.equals("")
            				&& !key.equals(  vo.getString("DPT_NM")+(vo.getString("GBN").equals("3") ? "2" : vo.getString("GBN")))  ) {


		                hnwExtQuery.AddData(dpt_nm);
		                hnwExtQuery.AddData(dpt_seq);
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(incm_tax));
		                hnwExtQuery.AddData(String.valueOf(citi_tax));

		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(eno_cnt)+"��");
		                hnwExtQuery.AddData("��");

		                hnwExtQuery.SendData(response);

		                //���� �ʱ�ȭ
		                incm_tax = 0;
		                citi_tax = 0;
		                eno_cnt  = 0;

		                //�� ī��Ʈ
		                tot_num++;

		            }
				}


	            else {

					//�踦 ����ô�. �ι�° ���� �μ��� �ٸ��� �谡 �ϳ��� ���� ���
		            if(tot_num > 0) {


		                hnwExtQuery.AddData(dpt_nm);
		                hnwExtQuery.AddData(dpt_seq);
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(incm_tax));
		                hnwExtQuery.AddData(String.valueOf(citi_tax));

		                hnwExtQuery.AddData(" ");
		                hnwExtQuery.AddData(String.valueOf(eno_cnt)+"��");
		                hnwExtQuery.AddData("��");

		                hnwExtQuery.SendData(response);


		            }


		            //�Ұ踦 ����ô�.
	                hnwExtQuery.AddData(dpt_nm);
	                hnwExtQuery.AddData("");
	                hnwExtQuery.AddData(" ");
	                hnwExtQuery.AddData(" ");
	                hnwExtQuery.AddData(String.valueOf(incm_mid));
	                hnwExtQuery.AddData(String.valueOf(citi_mid));

	                hnwExtQuery.AddData(" ");
	                hnwExtQuery.AddData(String.valueOf(eno_mid)+"��");
	                hnwExtQuery.AddData("�Ұ�");

	                hnwExtQuery.SendData(response);

	                //���� �ʱ�ȭ
	                incm_tax = 0;
	                citi_tax = 0;
	                eno_cnt  = 0;

	                //���� �ʱ�ȭ
	                incm_mid = 0;
	                citi_mid = 0;
	                eno_mid  = 0;

	                tot_num  = 0;
	            }
            }


            //Ű �����
            key 	= vo.getString("DPT_NM")+(vo.getString("GBN").equals("3") ? "2" : vo.getString("GBN"));
            dpt_nm 	= vo.getString("DPT_NM");
            dpt_seq = vo.getString("DPT_SEQ");


            hnwExtQuery.AddData(vo.getString("DPT_NM"));
            hnwExtQuery.AddData(vo.getString("DPT_SEQ"));
            hnwExtQuery.AddData(vo.getString("GBN"));
            hnwExtQuery.AddData(vo.getString("ENO_NO"));
            hnwExtQuery.AddData(vo.getString("INCM_TAX"));
            hnwExtQuery.AddData(vo.getString("CITI_TAX"));

            hnwExtQuery.AddData(vo.getString("BIGO"));
            hnwExtQuery.AddData(vo.getString("ENO_NM"));
            hnwExtQuery.AddData(vo.getString("NUM"));

            hnwExtQuery.SendData(response);


            //�� ���ϱ�
            incm_tax += new Long(vo.getString("INCM_TAX")).longValue();
            citi_tax += new Long(vo.getString("CITI_TAX")).longValue();

            eno_cnt++;

            incm_mid += new Long(vo.getString("INCM_TAX")).longValue();
            citi_mid += new Long(vo.getString("CITI_TAX")).longValue();

            eno_mid++;



            //������ �������� ���ϱ�
            if(vo.getString("GBN").equals("1")) {
            	incm_tot_1 += new Long(vo.getString("INCM_TAX")).longValue();
                citi_tot_1 += new Long(vo.getString("CITI_TAX")).longValue();

                eno_tot_1++;
            }
            else if(vo.getString("GBN").equals("2")) {
            	incm_tot_2 += new Long(vo.getString("INCM_TAX")).longValue();
                citi_tot_2 += new Long(vo.getString("CITI_TAX")).longValue();

                eno_tot_2++;
            }
            else if(vo.getString("GBN").equals("3")) {
            	incm_tot_3 += new Long(vo.getString("INCM_TAX")).longValue();
                citi_tot_3 += new Long(vo.getString("CITI_TAX")).longValue();

                eno_tot_3++;
            }





            if(i+1 == voList.size()) {

                //������ �Ұ踦 ����ô�.
                if(eno_cnt != 0) {

                	if(tot_num > 0) {
	                    hnwExtQuery.AddData(dpt_nm);
	                    hnwExtQuery.AddData(dpt_seq);
	                    hnwExtQuery.AddData(" ");
	                    hnwExtQuery.AddData(" ");
	                    hnwExtQuery.AddData(String.valueOf(incm_tax));
	                    hnwExtQuery.AddData(String.valueOf(citi_tax));

	                    hnwExtQuery.AddData(" ");
	                    hnwExtQuery.AddData(String.valueOf(eno_cnt)+"��");
	                    hnwExtQuery.AddData("��");

	                    hnwExtQuery.SendData(response);

                	}


                    hnwExtQuery.AddData(dpt_nm);
                    hnwExtQuery.AddData("");
                    hnwExtQuery.AddData(" ");
                    hnwExtQuery.AddData(" ");
                    hnwExtQuery.AddData(String.valueOf(incm_mid));
                    hnwExtQuery.AddData(String.valueOf(citi_mid));

                    hnwExtQuery.AddData(" ");
                    hnwExtQuery.AddData(String.valueOf(eno_mid)+"��");
                    hnwExtQuery.AddData("�Ұ�");

                    hnwExtQuery.SendData(response);

                    //���� �ʱ�ȭ
                    incm_mid = 0;
                    citi_mid = 0;
                    eno_mid  = 0;

                    //���� �ʱ�ȭ
                    incm_tax = 0;
                    citi_tax = 0;
                    eno_cnt  = 0;

                    tot_num  = 0;
                }


                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData("999991");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(String.valueOf(incm_tot_1));
                hnwExtQuery.AddData(String.valueOf(citi_tot_1));

                hnwExtQuery.AddData("������");
                hnwExtQuery.AddData(String.valueOf(eno_tot_1)+"��");
                hnwExtQuery.AddData("��  ��");

                hnwExtQuery.SendData(response);



                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData("999992");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(String.valueOf(incm_tot_2));
                hnwExtQuery.AddData(String.valueOf(citi_tot_2));

                hnwExtQuery.AddData("������(�ٷμҵ�)");
                hnwExtQuery.AddData(String.valueOf(eno_tot_2)+"��");
                hnwExtQuery.AddData(" ");

                hnwExtQuery.SendData(response);



                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData("999993");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(String.valueOf(incm_tot_3));
                hnwExtQuery.AddData(String.valueOf(citi_tot_3));

                hnwExtQuery.AddData("������(�����ҵ�)");
                hnwExtQuery.AddData(String.valueOf(eno_tot_3)+"��");
                hnwExtQuery.AddData("");

                hnwExtQuery.SendData(response);



                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData("999999");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(String.valueOf(incm_tot_1+incm_tot_2+incm_tot_3));
                hnwExtQuery.AddData(String.valueOf(citi_tot_1+citi_tot_2+citi_tot_3));

                hnwExtQuery.AddData(" ");
                hnwExtQuery.AddData(String.valueOf(eno_tot_1+eno_tot_2+eno_tot_3)+"��");
                hnwExtQuery.AddData("");

                hnwExtQuery.SendData(response);

                break;
            }

            i++;
        }
    }
    hnwExtQuery.EndData(response);







%>
