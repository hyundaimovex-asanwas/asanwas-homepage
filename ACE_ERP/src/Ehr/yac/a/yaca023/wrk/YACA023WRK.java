package Ehr.yac.a.yaca023.wrk;

import Ehr.yac.a.yaca023.dao.YACA023DAO;
import Ehr.yac.a.yaca030.dao.YACA030DAO;
import Ehr.yac.a.yaca040.dao.YACA040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA023WRK {
	
    private YACA023DAO dao = null;
    private String connectionName = "default";

    /**
     * 2013�⵵ �������� �����ٹ��� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA023_SHR_PLA(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA023DAO(connectionName, p_tr);
        p_tr.setOutDataSet("dsT_AC_DUTYPLACE", dao.YACA023_SHR_PLA(p_box)); //1.�����ٹ����ڷ� ������ ������� DS �� ���

    }

    /**
     * 2013�⵵ �������� �����ٹ��� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA023_SHR_PLA_14(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA023DAO(connectionName, p_tr);
        p_tr.setOutDataSet("dsT_AC_DUTYPLACE", dao.YACA023_SHR_PLA_14(p_box)); //1.�����ٹ����ڷ� ������ ������� DS �� ���

    }
    
    /**
     * 2015�⵵ �������� �����ٹ��� ������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA023_SHR_PLA_15(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA023DAO(connectionName, p_tr);
        p_tr.setOutDataSet("dsT_AC_DUTYPLACE", dao.YACA023_SHR_PLA_15(p_box)); //1.�����ٹ����ڷ� ������ ������� DS �� ���

    }
    
    
    /**
     * 2013�⵵ �������� �����ٹ��� ������ ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA023_SAV(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject pla_vo = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE").get(0);

        GauceValueObject vo = null;

        dao = new YACA023DAO(connectionName, p_tr);

        //1.�����ٹ����� �Է��ϱ� �� ��� ������ ����
        dao.YACA023_DEL_PLA(p_box);

        //2.�����ٹ����� ���
        for (int i=1; i<=3; i++) {
            if(pla_vo.getString("TYPE"+i).equals("X")) {
                vo = new GauceValueObject();

                vo.set("SEQ_NO", i);
                vo.set("JAO_NO"  , pla_vo.get("JAO_NO"+i   ));
                vo.set("JAS_NM"  , pla_vo.get("JAS_NM"+i   ));
                vo.set("HIR_YMD" , pla_vo.get("HIR_YMD"+i  ));
                vo.set("RET_YMD" , pla_vo.get("RET_YMD"+i  ));
                vo.set("JAA_AMT" , pla_vo.get("JAA_AMT"+i  ));
                vo.set("JAC_AMT" , pla_vo.get("JAC_AMT"+i  ));
                vo.set("JAG_AMT" , pla_vo.get("JAG_AMT"+i  ));
                vo.set("JAG_CD" , pla_vo.get("JAG_CD"+i  ));                     
                vo.set("JAI_AMT" , pla_vo.get("JAI_AMT"+i  ));
                vo.set("JAQ_AMT" , pla_vo.get("JAQ_AMT"+i  ));
                vo.set("JAR_AMT" , pla_vo.get("JAR_AMT"+i  ));
                vo.set("JAH_AMT" , pla_vo.get("JAH_AMT"+i  ));
                vo.set("JAP_AMT" , pla_vo.get("JAP_AMT"+i  ));
                vo.set("JAL_AMT" , pla_vo.get("JAL_AMT"+i  ));
                vo.set("JAN_AMT" , pla_vo.get("JAN_AMT"+i  ));

                dao.YACA023_INS_PLA(p_box, vo);
            }
        }
   
    }

    
    /**
     * 2014�⵵ �������� �����ٹ��� ������ ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA023_SAV_14(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject pla_vo = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE").get(0);

        GauceValueObject vo = null;

        dao = new YACA023DAO(connectionName, p_tr);

        //1.�����ٹ����� �Է��ϱ� �� ��� ������ ����
        //dao.YACA023_DEL_PLA_14(p_box);

        //2.�����ٹ����� ���
        for (int i=1; i<=3; i++) {
            if(pla_vo.getString("TYPE"+i).equals("X")) {
                vo = new GauceValueObject();

                vo.set("SEQ_NO", i);
                vo.set("JAO_NO"  , pla_vo.get("JAO_NO"+i   ));
                vo.set("JAS_NM"  , pla_vo.get("JAS_NM"+i   ));
                vo.set("HIR_YMD" , pla_vo.get("HIR_YMD"+i  ));
                vo.set("RET_YMD" , pla_vo.get("RET_YMD"+i  ));
                vo.set("JAA_AMT" , pla_vo.get("JAA_AMT"+i  ));
                vo.set("JAC_AMT" , pla_vo.get("JAC_AMT"+i  ));
                vo.set("JAG_AMT" , pla_vo.get("JAG_AMT"+i  ));
                vo.set("JAG_CD" , pla_vo.get("JAG_CD"+i  ));                     
                vo.set("JAI_AMT" , pla_vo.get("JAI_AMT"+i  ));
                vo.set("JAQ_AMT" , pla_vo.get("JAQ_AMT"+i  ));
                vo.set("JAR_AMT" , pla_vo.get("JAR_AMT"+i  ));
                vo.set("JAH_AMT" , pla_vo.get("JAH_AMT"+i  ));
                vo.set("JAP_AMT" , pla_vo.get("JAP_AMT"+i  ));
                vo.set("JAL_AMT" , pla_vo.get("JAL_AMT"+i  ));
                vo.set("JAN_AMT" , pla_vo.get("JAN_AMT"+i  ));

        		this.YACA023_INS_PLA_14(p_box, p_tr, vo);
                //dao.YACA023_INS_PLA_14(p_box, vo);
            }
        }
   
    }    
    
    
    /**
     * 2015�⵵ �������� �����ٹ��� ������ ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA023_SAV_15(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject pla_vo = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE").get(0);

        GauceValueObject vo = null;

        dao = new YACA023DAO(connectionName, p_tr);

        //1.�����ٹ����� �Է��ϱ� �� ��� ������ ����
        //dao.YACA023_DEL_PLA_14(p_box);

        //2.�����ٹ����� ���
        for (int i=1; i<=3; i++) {
            if(pla_vo.getString("TYPE"+i).equals("X")) {
                vo = new GauceValueObject();

                vo.set("SEQ_NO", i);
                vo.set("JAO_NO"  , pla_vo.get("JAO_NO"+i   ));
                vo.set("JAS_NM"  , pla_vo.get("JAS_NM"+i   ));
                vo.set("HIR_YMD" , pla_vo.get("HIR_YMD"+i  ));
                vo.set("RET_YMD" , pla_vo.get("RET_YMD"+i  ));
                vo.set("JAA_AMT" , pla_vo.get("JAA_AMT"+i  ));
                vo.set("JAC_AMT" , pla_vo.get("JAC_AMT"+i  ));
                vo.set("JAG_AMT" , pla_vo.get("JAG_AMT"+i  ));
                vo.set("JAG_CD" , pla_vo.get("JAG_CD"+i  ));                     
                vo.set("JAI_AMT" , pla_vo.get("JAI_AMT"+i  ));
                vo.set("JAQ_AMT" , pla_vo.get("JAQ_AMT"+i  ));
                vo.set("JAR_AMT" , pla_vo.get("JAR_AMT"+i  ));
                vo.set("JAH_AMT" , pla_vo.get("JAH_AMT"+i  ));
                vo.set("JAP_AMT" , pla_vo.get("JAP_AMT"+i  ));
                vo.set("JAL_AMT" , pla_vo.get("JAL_AMT"+i  ));
                vo.set("JAN_AMT" , pla_vo.get("JAN_AMT"+i  ));

        		this.YACA023_INS_PLA_15(p_box, p_tr, vo);
                //dao.YACA023_INS_PLA_14(p_box, vo);
            }
        }
   
    }    
    
	public void YACA023_INS_PLA_14(CBox p_box, TrBox p_tr, GauceValueObject vo) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA023DAO dao = new YACA023DAO("default", p_tr);

		dao.YACA023_INS_PLA_14(p_box, vo);


	}
	
	public void YACA023_INS_PLA_15(CBox p_box, TrBox p_tr, GauceValueObject vo) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA023DAO dao = new YACA023DAO("default", p_tr);

		dao.YACA023_INS_PLA_15(p_box, vo);


	}
  
    
    
	/**
	 * �����ٹ��� ���� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA023_DEL_PLA_14( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE");
	
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA023DAO dao = new YACA023DAO("default", p_tr);

		dao.YACA023_DEL_PLA_14(p_box);

	}
	
	/**
	 * �����ٹ��� ���� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA023_DEL_PLA_15( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE");
	
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		YACA023DAO dao = new YACA023DAO("default", p_tr);

		dao.YACA023_DEL_PLA_15(p_box);

	}

}

