package Ehr.yac.a.yaca090.wrk;

import Ehr.yac.a.yaca090.dao.YACA090DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class YACA090WRK {
    private YACA090DAO dao = null;
    private String connectionName = "default";

    /**
     * 작업 현황을 가져온다.
     * @param p_box
     * @throws CException
     */
    public void YACA090_SHR(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA090DAO(connectionName, p_tr);
        dao.YACA090_SHR_LOG_DS(p_box);
    }

    /**
     * 대상자선정
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC2(CBox p_box, TrBox p_tr) throws CException {

        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        System.out.println("vo.get::"+vo.get("PIS_YY"));
        
        dao.YACA090_INS_02(p_box, vo, vo.get("PIS_YY"));
    }

    /**
     * 정산계산작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC3(CBox p_box, TrBox p_tr) throws CException {

        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        //년도마다 다른 프로시저를 태운다.

        dao.YACA090_INS_03(p_box, vo, vo.get("PIS_YY"));
    }

    /**
     * 정산계산작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC3_142(CBox p_box, TrBox p_tr) throws CException {

        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        //년도마다 다른 프로시저를 태운다.

        dao.YACA090_INS_03_142(p_box, vo, vo.get("PIS_YY"));
    }    

    
    /**
     * 정산계산작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC3_15(CBox p_box, TrBox p_tr) throws CException {

        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        //년도마다 다른 프로시저를 태운다.

        dao.YACA090_INS_03_15(p_box, vo, vo.get("PIS_YY"));
    }    

    
    
    
    /**
     * 작업종료
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC4(CBox p_box, TrBox p_tr) throws CException {
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        dao.YACA090_INS_04(p_box, vo);
    }

    /**
     * 대상자선정 재작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC5(CBox p_box, TrBox p_tr) throws CException {
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        dao.YACA090_INS_05(p_box, vo);
    }

    /**
     * 정산계산작업 재작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC6(CBox p_box, TrBox p_tr) throws CException {
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        dao.YACA090_INS_06(p_box, vo);
    }

    /**
     * 정산계산작업 재작업
     * @param p_box
     * @param p_tr
     */
    public void YACA090_PROC6_142(CBox p_box, TrBox p_tr) throws CException {
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
        dao = new YACA090DAO(connectionName, p_tr);

        int i=0;

        /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
        GauceValueObject vo = voList.get(i);    // LIST -> ROW

        dao.YACA090_INS_06_142(p_box, vo);
    }    
    
   
    
}