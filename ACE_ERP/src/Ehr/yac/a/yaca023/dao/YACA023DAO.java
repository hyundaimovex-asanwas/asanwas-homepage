package Ehr.yac.a.yaca023.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class YACA023DAO extends AbstractDAO {

	/**
	 * YACA023DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public YACA023DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * JSP�� ���� ������ �߰�
     * Transaction �� ó����������
     * @param p_conn
     * @throws CException
     */
    public YACA023DAO(String p_conn) throws CException {
        super(p_conn);
    }

    /**
     * ���� �ٹ��� ���� ��������
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet YACA023_SHR_PLA(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_SHR_PLA");

        
    	//System.out.println("p_box"+p_box.toString());        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("HIR_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);


        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
    }

    
    /**
     * ���� �ٹ��� ���� ��������
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet YACA023_SHR_PLA_14(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_SHR_PLA_14");

        
    	//System.out.println("p_box"+p_box.toString());        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("HIR_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);


        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
    }    
    
    /**
     * ���� �ٹ��� ���� ��������
     * @param p_box
     * @return
     * @throws CException
     */
    public GauceDataSet YACA023_SHR_PLA_15(CBox p_box) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_SHR_PLA_15");

    	//System.out.println("p_box"+p_box.toString());        
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        prop.add("HIR_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD1", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT1", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD2", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT2", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);

        prop.add("HIR_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("RET_YMD3", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAA_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAC_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAG_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAI_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAQ_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAR_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAH_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAP_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAL_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("JAN_AMT3", ColumnProp.COLUMN_TYPE_DECIMAL, 9.0, ColumnProp.CONSTRAINT_TB_NORMAL);


        //�� ������ DataSet ��������
        return this.selectProcess(Query, bind, prop);
    }    
    
    /**
     * ���� �ٹ��� ���� ��� ����
     * @param p_box
     * @throws CException
     */
    public void YACA023_DEL_PLA(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_DEL_PLA");

    	//System.out.println("p_box"+p_box.toString());         
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        this.deleteProcess(Query, bind);
    }

    /**
     * ���� �ٹ��� ���� ��� ����
     * @param p_box
     * @throws CException
     */
    public void YACA023_DEL_PLA_14(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_DEL_PLA_14");

    	//System.out.println("p_box"+p_box.toString());         
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        this.deleteProcess(Query, bind);
    }    
    
    /**
     * ���� �ٹ��� ���� ��� ����
     * @param p_box
     * @throws CException
     */
    public void YACA023_DEL_PLA_15(CBox p_box) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_DEL_PLA_15");

    	//System.out.println("p_box"+p_box.toString());         
        
        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
        };

        this.deleteProcess(Query, bind);
    }    
    
    /**
     * ���� �ٹ��� ���� ���
     * @param p_box
     * @throws CException
     */
    public void YACA023_INS_PLA(CBox p_box, GauceValueObject vo) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_INS_PLA");

        String SES_ENO_NO = p_box.get("SESSION_ENONO");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("SEQ_NO")
                ,vo.get("JAO_NO")
                ,vo.get("JAS_NM")
                ,vo.get("HIR_YMD").replaceAll("-", "")
                ,vo.get("RET_YMD").replaceAll("-", "")
                ,vo.get("JAA_AMT")
                ,vo.get("JAC_AMT")
                ,vo.get("JAG_AMT")
                ,vo.get("JAG_CD")                
                ,vo.get("JAI_AMT")
                ,vo.get("JAQ_AMT")
                ,vo.get("JAR_AMT")
                ,vo.get("JAH_AMT")
                ,vo.get("JAP_AMT")
                ,vo.get("JAL_AMT")
                ,vo.get("JAN_AMT")
                ,Double.toString(Double.parseDouble(vo.get("JAA_AMT")) + Double.parseDouble(vo.get("JAC_AMT")) + Double.parseDouble(vo.get("JAI_AMT")))
                ,SES_ENO_NO
                ,SES_ENO_NO
        };

        this.insertProcess(Query, bind);
    }
	
    /**
     * ���� �ٹ��� ���� ���
     * @param p_box
     * @throws CException
     */
    public void YACA023_INS_PLA_14(CBox p_box, GauceValueObject vo) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_INS_PLA_14");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("SEQ_NO")
                ,vo.get("JAO_NO")
                ,vo.get("JAS_NM")
                ,vo.get("HIR_YMD").replaceAll("-", "")
                ,vo.get("RET_YMD").replaceAll("-", "")
                ,vo.get("JAA_AMT")
                ,vo.get("JAC_AMT")
                ,vo.get("JAG_AMT")
                ,vo.get("JAG_CD")                
                ,vo.get("JAI_AMT")
                ,vo.get("JAQ_AMT")
                ,vo.get("JAR_AMT")
                ,vo.get("JAH_AMT")
                ,vo.get("JAP_AMT")
                ,vo.get("JAL_AMT")
                ,vo.get("JAN_AMT")
                ,Double.toString(Double.parseDouble(vo.get("JAA_AMT")) + Double.parseDouble(vo.get("JAC_AMT")) + Double.parseDouble(vo.get("JAI_AMT")))
				,p_box.get("vusrid")				//�Է���
				,p_box.get("vusrid")				//������
        };

        this.insertProcess(Query, bind);
    }
    
    /**
     * ���� �ٹ��� ���� ���
     * @param p_box
     * @throws CException
     */
    public void YACA023_INS_PLA_15(CBox p_box, GauceValueObject vo) throws CException {
    	
        //Query ��������
        String Query = XmlSqlUtils.getSQL("yac", "YACA023_INS_PLA_15");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 p_box.get("PIS_YY")
                ,p_box.get("ENO_NO")
                ,vo.get("SEQ_NO")
                ,vo.get("JAO_NO")
                ,vo.get("JAS_NM")
                ,vo.get("HIR_YMD").replaceAll("-", "")
                ,vo.get("RET_YMD").replaceAll("-", "")
                ,vo.get("JAA_AMT")
                ,vo.get("JAC_AMT")
                ,vo.get("JAG_AMT")
                ,vo.get("JAG_CD")                
                ,vo.get("JAI_AMT")
                ,vo.get("JAQ_AMT")
                ,vo.get("JAR_AMT")
                ,vo.get("JAH_AMT")
                ,vo.get("JAP_AMT")
                ,vo.get("JAL_AMT")
                ,vo.get("JAN_AMT")
                ,Double.toString(Double.parseDouble(vo.get("JAA_AMT")) + Double.parseDouble(vo.get("JAC_AMT")) + Double.parseDouble(vo.get("JAI_AMT")))
				,p_box.get("vusrid")				//�Է���
				,p_box.get("vusrid")				//������
        };

        this.insertProcess(Query, bind);
    }
	
}
