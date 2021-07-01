package Ehr.common.commnm.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class COMMNMDAO extends AbstractDAO {
	/**
	 * EDUG010DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public COMMNMDAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 *�����ڵ�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),                // ����
				p_box.get("COMM_CD"),             // �ڵ�
				p_box.get("COMM_CD")              // �ڵ�
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

    /**
     * �����ڵ���� ��ȸ�� �´�.
     * @param p_box
     * @throws CException
     */
	public void COMMNM_SHR_00(CBox p_box) throws CException {

	    /** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_00");

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    
	    
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	    Object[] bind = new Object[] {
	            p_box.get("CODE_GUBUN"),                // ����
	            p_box.get("CODE_GUBUN")                // ����
	    };

	    /** FirstRow�޼ҵ� ȣ�� **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 *�μ�/��/���θ� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_02");

		/** ��ȸ ���ǿ� ���� ó�� #1 **/
		StringBuffer sb = new StringBuffer();

		/** �˻������� �μ��� ��� */
		if (p_box.get("CD_GBN").equals("A4")) {
			sb.append("AND   (SORT_NO BETWEEN 100 AND 750 OR DPT_CD = 'IT')");
		}
		/** �˻������� ���� ��� */
		else if (p_box.get("CD_GBN").equals("A6")) {
			sb.append("AND    UPDPT_CD LIKE '" + p_box.get("UP_CD") + "'||'%'");
			sb.append("AND 	  (END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("SESSION_TODAY").replaceAll("-", "")+"')");
		}
		/** �˻������� ������ ��� */
		else if (p_box.get("CD_GBN").equals("B2")) {
			sb.append("AND 	  (END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("SESSION_TODAY").replaceAll("-", "")+"')");
		}

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),                // ����
				p_box.get("COMM_CD"),             // �ڵ�
				p_box.get("COMM_CD")              // �ڵ�
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �����ڵ�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_04");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD"),             // �ڵ�
				p_box.get("COMM_CD")              // �ڵ�
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �����ڵ�� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_04(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_05");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD")              // ��������
		};

        /** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �޺��ڽ� �ڵ� ����(�λ���)
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_06(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_06");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),
				p_box.get("EVL_YY")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �ش� �Ҽ��� �ι��� �����´�
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_07(CBox p_box) throws CException {

		/** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_07");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),
				p_box.get("DPT_CD")
		};

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

    /**
     * �μ��ڵ���� ��ȸ�� �´�.
     * @param p_box
     * @throws CException
     */
	public void COMMNM_SHR_DPT(CBox p_box) throws CException {
	    /** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT");
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow�޼ҵ� ȣ�� **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}
	public void COMMNM_SHR_DPT2(CBox p_box) throws CException {
	    /** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT2");
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow�޼ҵ� ȣ�� **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}
	public void COMMNM_SHR_DPT3(CBox p_box) throws CException {
	    /** �ܺ� XML���� �����ڵ�� ��ȸ SQL ���� **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT3");
	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow�޼ҵ� ȣ�� **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}

}
