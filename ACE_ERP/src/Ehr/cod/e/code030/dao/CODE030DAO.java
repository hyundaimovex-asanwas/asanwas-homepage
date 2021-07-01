package Ehr.cod.e.code030.dao;

import Ehr.common.util.JSPUtil;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODE030DAO extends AbstractDAO {
	/**
	 * PIRA020DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODE030DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ����� ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR");

		
		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")) && !(p_box.get("vusrid").equals("6070001")) && !(p_box.get("vusrid").equals("6050006"))){
			
			sb.append("WHERE PRO_STS = '6'");
		}
	
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);			
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	  	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("ENO_NO"),	    // ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * �޿����޾� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    	// �ش��
				p_box.get("SAL_GBN"),	    	// �޻󿩱���
				p_box.get("ENO_NO"),	   	 	// ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}



	/**
	 * �Ϲ� ���� ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� �Ϲ� ���� ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("ENO_NO"),	    // ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}




	/**
	 * ����/���� ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� ����/���� ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_03");

		StringBuffer sb = new StringBuffer();

        if( p_box.get("ENO_NO").equals("2040038")){
			sb.append(" UNION SELECT '���̵帲' AS BNK_NM, '���ѻ���' AS COMM_NM,'����' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_BAK  FROM DUAL  ");
		}

        //System.out.println(p_box.get("ENO_NO"));

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    	// �ش��
				p_box.get("SAL_GBN"),	    	// �޻󿩱���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    	// �ش��
				p_box.get("SAL_GBN"),	   		// �޻󿩱���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),

		};

		prop.add("BNK_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("SAV_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUBUN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * �۾� �Ϸ� ���� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet CODE030_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� �۾� �Ϸ� ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("ENO_NO"),	    // ���
		};

		/** selectProcess�޼ҵ� ȣ�� **/
		return selectProcess(sql, bind, prop);
	}



	/**
	 * ������ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_05(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_05");

		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")|| p_box.get("vusrid").equals("6070001")|| p_box.get("vusrid").equals("6050006"))){
			
			sb.append("AND B.PRO_STS = '6'");
		}
	
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);	
		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("SAL_GBN"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),

		};

		prop.add("SALT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("INCM_TAX", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CITI_TAX", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINU_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NPEN_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINS_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}





	/**
	 * �޿����޾� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void CODE030_SHR_06(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_06");

		//�۾��Ϸ� ���θ� ��ȸ
		GauceDataSet ds = this.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

        //System.out.println(p_box.get("SESSION_ROLE_CD"));

		StringBuffer sb = new StringBuffer();
		if(!(p_box.get("SESSION_ROLE_CD").equals("1001")|| p_box.get("SESSION_ROLE_CD").equals("1002")|| Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6)){
			sb.append("WHERE PRO_STS = '6'");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	  	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("ENO_NO"),	    // ���
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * �μ� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT(CBox p_box) throws CException {


	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    // �ش��
				p_box.get("SAL_GBN"),	    // �޻󿩱���
				p_box.get("ENO_NO"),	    // ���
	    };

	    this.selectProcessFirstRow(sql, bind, prop);		

	}

	/**
	 * �μ� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT2(CBox p_box) throws CException {

		/** �ܺ� XML���� ����/���� ���� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT2");

		StringBuffer sb = new StringBuffer();

        if( p_box.get("ENO_NO").equals("2040038")){
			sb.append(" UNION SELECT '���̵帲' AS BNK_NM, '���ѻ���' AS COMM_NM,'����' AS GUBUN, '2014-06-30' AS DUE_YMD, 0 AS PYM_AMT, 120 AS PIN_CNT, 8716500 AS SUM_PYM, 0 AS GMK_BAK  FROM DUAL  ");
		}

        //System.out.println(p_box.get("ENO_NO"));

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    	// �ش��
				p_box.get("SAL_GBN"),	    	// �޻󿩱���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY"),	    	// �ش��
				p_box.get("PIS_MM"),	    	// �ش��
				p_box.get("SAL_GBN"),	   		// �޻󿩱���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("ENO_NO"),	    	// ���
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),				
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY")+p_box.get("PIS_MM"),

		};

		prop.add("BNK_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("SAV_NM", ColumnProp.COLUMN_TYPE_STRING , 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUBUN", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_NORMAL);


		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
	/**
	 * �μ� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void  CODE030_SHR_PRINT3(CBox p_box) throws CException {

		/** �ܺ� XML���� �޻����޾� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODE030_SHR_PRINT3");

		StringBuffer sb = new StringBuffer();

		if(!(p_box.get("vusrid").equals("6060002")|| p_box.get("vusrid").equals("6070001")|| p_box.get("vusrid").equals("6050006"))){
			
			sb.append("AND B.PRO_STS = '6'");
		}
	
		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString(),
		};
  
		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);	
		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("SAL_GBN"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),
				p_box.get("PIS_YY"),
				p_box.get("PIS_MM"),

		};

		prop.add("SALT_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("INCM_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("CITI_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINU_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("NPEN_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HINS_SUM", ColumnProp.COLUMN_TYPE_DECIMAL, 15, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
}
