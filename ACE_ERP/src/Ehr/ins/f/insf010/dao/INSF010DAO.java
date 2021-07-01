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
	 * INSB010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSF010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 직원 정보를 조회해 온다.
     * @param p_box
     * @throws CException
     */
    public void INSF010_SHR_EMP(CBox p_box) throws CException {
    	
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_SHR_EMP");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }

    /**
     * 개인연금 관리 내역을 가져옵니다.
     * @param p_box
     * @throws CException
     */
    public void INSF010_SHR(CBox p_box) throws CException {
    	
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO"))
        };
        
        prop.add("DSC_PCT"    ,ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
        
    }

    /**
     * 신규로 등록한 개인연금 내역을 DB에 등록한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_INS(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_INS");

        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));
        String SES_ENO_NO = p_box.get("vusrid");

        //param binding 하기
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

        /** INSERT메소드 호출 * */
        insertProcess(Query, bind);
    }

    /**
     * 수정한 개인연금 내역을 DB에 수정한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_UPT(CBox p_box, GauceValueObject vo) throws CException {
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_UPT");

        String SES_ENO_NO = p_box.get("vusrid");
        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));

        //param binding 하기
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

        /** UPDATE메소드 호출  **/
        updateProcess(Query, bind);
    }

    /**
     * 개인연금을 삭제한다.
     * @param p_box
     * @param vo
     * @throws CException
     */
    public void INSF010_DEL(CBox p_box, GauceValueObject vo) throws CException{
        //Query 가져오기
        String Query = XmlSqlUtils.getSQL("ins", "INSF010_DEL");

        String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));

        //param binding 하기
        Object[] bind = new Object[] {
                 ENO_NO
                ,vo.get("BNK_CD")
                ,vo.get("ACC_NO")
                ,vo.get("SAV_CD2")
        };

        /** DELETE메소드 호출  **/
        deleteProcess(Query, bind);
    }
}
