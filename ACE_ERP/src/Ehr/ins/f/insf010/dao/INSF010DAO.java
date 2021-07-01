package Ehr.ins.f.insf010.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class INSF010DAO extends AbstractDAO {
	/**
	 * INSB010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSF010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

    /**
     * ���� ������ ��ȸ�� �´�.
     * @param p_box
     * @throws CException
     */
    public void INSF010_SHR_EMP(CBox p_box) throws CException {
    	
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_SHR_EMP");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * ���ο��� ���� ������ �����ɴϴ�.
     * @param p_box
     * @throws CException
     */
    public void INSF010_SHR(CBox p_box) throws CException {
    	
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_SHR");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        prop.add("DSC_PCT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
        //�� ������ DataSet ��������
        this.selectProcessFirstRow(Query, bind, prop);
        
    }

    /**
     * �űԷ� ����� ���ο��� ������ DB�� ����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_INS(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_INS");

        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));
        String SES_ENO_NO = p_box.get("vusrid");

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 ENO_NO
                ,vo.get("SAV_CD2")
                ,vo.get("SAV_CD2")
                ,vo.get("CON_YMD")
                ,vo.get("DUE_YMD")
                ,vo.get("CONM_AMT")
                ,vo.get("DSC_PCT")
                ,vo.get("DSC_AMT")
                ,vo.get("WOL_AMT")
                ,vo.get("OTHP_AMT")
                ,vo.get("OTH_AMT")
                ,vo.get("SUM_SAV")
                ,vo.get("SUMP_CNT")
                ,vo.get("FAPP_YMD")
                ,vo.get("CAN_TAG")
                ,vo.get("CAN_YMD")
                ,SES_ENO_NO
                ,SES_ENO_NO
        };
        prop.add("DSC_PCT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

        /** INSERT�޼ҵ� ȣ�� * */
        insertProcess(Query, bind);
    }

    /**
     * ������ ���ο��� ������ DB�� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_UPT(CBox p_box, GauceValueObject vo) throws CException {
        //Query ��������
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_UPT");

        String SES_ENO_NO = p_box.get("vusrid");
        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 vo.get("CAN_TAG")
                ,vo.get("CAN_YMD")
                ,vo.get("DUE_YMD")
                ,vo.get("CONM_AMT")
                ,vo.get("DSC_PCT")
                ,vo.get("DSC_AMT")
                ,vo.get("WOL_AMT")
                ,vo.get("OTHP_AMT")
                ,vo.get("OTH_AMT")
                ,SES_ENO_NO
                ,ENO_NO
                ,vo.get("ACC_NO")
                ,vo.get("SAV_CD2")
        };
        prop.add("DSC_PCT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);

        /** UPDATE�޼ҵ� ȣ��  **/
        updateProcess(Query, bind);
    }

    /**
     * ���ο����� �����Ѵ�.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_DEL(CBox p_box, GauceValueObject vo) throws CException{
        //Query ��������
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_DEL");

        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));

        //param binding �ϱ�
        Object[] bind = new Object[] {
                 ENO_NO
                ,vo.get("BNK_CD")
                ,vo.get("ACC_NO")
                ,vo.get("SAV_CD2")
        };

        /** DELETE�޼ҵ� ȣ��  **/
        deleteProcess(Query, bind);
    }
}
