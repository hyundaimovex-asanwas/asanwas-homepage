package Ehr.yac.a.yaca050.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA050DAO extends AbstractDAO {

	/**
	 * INSB050DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA050DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 */
	public void YACA050_PRT_15_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"yaca050_15",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"P"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA050_SHR(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_14");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
    }    
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_142");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * ������������ȸ�� �����´�.
     * @param p_box
     * @throws CException
     */
    public GauceDataSet YACA050_SHR_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_SHR_15");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        //this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * ������������ȸ�� �����´�. ��¹�  1,2page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		//prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * ������������ȸ�� �����´�. ��¹�  1,2page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

		//prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }        
    
    
    /**
     * ������������ȸ�� �����´�.  ��¹� 3page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_3(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_3");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    /**
     * ������������ȸ�� �����´�.  ��¹� 3page
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_3(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_3");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                
        };

		prop.add("TAX_INCOME", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("MNI_TOT", ColumnProp.COLUMN_TYPE_DECIMAL, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * ������������ȸ�� �����´�.   ��¹� 4page HEAD
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("ENO_NO")        
        };

        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * ������������ȸ�� �����´�.     ��¹� 4page ��������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_1(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_1");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * ������������ȸ�� �����´�.    ��¹� 4page ��������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_2(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_2");

        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       

    
    /**
     * ������������ȸ�� �����´�.  ��¹� 4page ���ø���
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_3(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_3");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * ������������ȸ�� �����´�.  ��¹� 4page ���������������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_142_4_4(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_142_4_4");
        
        System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * ������������ȸ�� �����´�.   ��¹� 4page HEAD
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4");
        
        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                p_box.get("ENO_NO")        
        };

        this.selectProcessFirstRow(Query, bind, prop);
    }       
    
    
    /**
     * ������������ȸ�� �����´�.     ��¹� 4page ��������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_1(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_1");

       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       
    
    
    /**
     * ������������ȸ�� �����´�.    ��¹� 4page ��������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_2(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_2");

        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
               
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")        
        };

		
        //System.out.println("TAX_INCOME 20150216  =========================================== " + TAX_INCOME);	         
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
        //�� ������ DataSet ��������
        //return this.selectProcess(Query, bind, prop);        
        
    }       

    
    /**
     * ������������ȸ�� �����´�.  ��¹� 4page ���ø���
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_3(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_3");
        
        //System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
    /**
     * ������������ȸ�� �����´�.  ��¹� 4page ���������������
     * @param p_box
     * @throws CException
     */
    public void YACA050_PRT_15_4_4(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA050_PRT_15_4_4");
        
       // System.out.println("p_box 20150216  =========================================== " + p_box);	        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
        		 p_box.get("PIS_YY")
                 ,p_box.get("ENO_NO")        
        };

	
        this.selectProcessFirstRow(Query, bind, prop);
        
    }        
    
}
