package Ehr.yac.a.yaca001.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.DynamicValueObject;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA001DAO extends AbstractDAO {

	public YACA001DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * JSP�� ���� ������ �߰�
     * Transaction �� ó����������
     * @param p_conn
     * @throws CException
     */
    public YACA001DAO(String p_conn) throws CException {
        super(p_conn);
    }
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("SUBMIT_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_14(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    

    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_15(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }    
    
    
    

    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
    */ 
    public void YACA001_SHR_142(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("PIS_YY_SHR")

        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }      

    
    /**
     * ��������  ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_14_AB(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_AB");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }    
    

    
    public DynamicValueObject YACA001_SHR_FILE_15_AB(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_15_AB");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    

    /**
     * ��������  ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_14_AB_142(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_AB_142");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		/*
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")*/
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }        
    
    
	/**
	 * ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_14_ETC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_ETC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}    
    
	/**
	 * ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_15_ETC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_15_ETC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}    
    

	/**
	 * ��������
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet YACA001_SHR_FILE_14_ETC_142(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_14_ETC_142");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				/*				
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(0,4),				
				*/

		};
/*
		prop.add("YAC_SALT_AMTS",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTB",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_SALT_AMTT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_INCOME", ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MGR_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_MNI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_NSE_TOT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_INDED_TOT",  ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TTAX_STD",   ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_TAX_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_JAI_AMT",    ColumnProp.COLUMN_TYPE_STRING,  12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YAC_HOL_YN",    ColumnProp.COLUMN_TYPE_STRING,  1, ColumnProp.CONSTRAINT_TB_NORMAL);
*/
		//System.out.println(p_box);
		
		GauceDataSet gs = this.selectProcess(sql, bind, prop);

		return gs;
		
	}       

    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_MED_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_MED_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }        
    
    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }       
    

    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA001_SHR_DON_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA001_SHR_DON_142");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY_SHR")
                ,p_box.get("PIS_YY_SHR")
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }       


    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }
    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02_142(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02_142");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    
    /**
     * �������� �Ƿ�� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_02_15(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_02_15");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
				p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }
    
    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03_15(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03_15");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }    
    
    /**
     * �������� ��α� ��ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */    
    public DynamicValueObject YACA001_SHR_FILE_03_142(CBox p_box) throws CException {

    	/** �ܺ� XML���� SQL�� �о� �´� **/
        String sql = XmlSqlUtils.getSQL("yac", "YACA001_SHR_FILE_03_142");

        /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
        Object[] bind = new Object[] {
        		p_box.get("PIS_YMD").replaceAll("-", ""),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),        		
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
        		p_box.get("PIS_YY_SHR"),
				p_box.get("PIS_YY_SHR")
        };

        /** Query ���� �� �ڷ� ������� ��ȯ **/
        return this.selectProcessDvo(sql, bind);

    }        
    
}
