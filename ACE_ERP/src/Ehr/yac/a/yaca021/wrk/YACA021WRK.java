package Ehr.yac.a.yaca021.wrk;

import Ehr.yac.a.yaca021.dao.YACA021DAO;
import Ehr.yac.a.yaca030.dao.YACA030DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA021WRK {
    private YACA021DAO dao = null;
    private String connectionName = "default";

    /**
     * 부양가족 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR(p_box);
    }

    /**
     * 2013년도 부양가족 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_13(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_13(p_box);
    }    
    
    /**
     * 2014년도 부양가족 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_14(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_14(p_box);
    }        
    
    /**
     * 2014년도 부양가족 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_142(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_142(p_box);
    }      
    
    
    /**
     * 2015년도 부양가족 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_15(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_15(p_box);
    }      
    
    
    /**
     * 부양가족 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_INFO(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_INFO(p_box);
    }

    /**
     * 부양가족 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_INFO_14(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_INFO_14(p_box);
    }    
    
    /**
     * 부양가족 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_INFO_142(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_INFO_142(p_box);
    }       
    
    /**
     * 부양가족 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_INFO_15(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_INFO_15(p_box);
    }       
    
    /**
     * 개인간 주택임차차입금을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_PER(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_PER(p_box);
    }
    
    /**
     * 개인간 주택임차차입금을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_PER_14(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_PER_14(p_box);
    }    
    
    /**
     * 개인간 주택임차차입금을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_PER_142(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_PER_142(p_box);
    }       
    
    /**
     * 개인간 주택임차차입금을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_PER_15(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_PER_15(p_box);
    }       
    
    /**
     * 월세계약 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_RENT(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_RENT(p_box);
    }    
    
    /**
     * 월세계약 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_RENT_14(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_RENT_14(p_box);
    }       
    
    /**
     * 월세계약 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_RENT_142(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_RENT_142(p_box);
    }      
    
    /**
     * 월세계약 상세 내역을 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SHR_RENT_15(CBox p_box, TrBox p_tr) throws CException {
        dao = new YACA021DAO(connectionName, p_tr);
        dao.YACA021_SHR_RENT_15(p_box);
    }      
    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_INS(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        if(voList.size() == 1) {
            dao.YACA021_INS(p_box, voList.get(0));
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }
    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_INS_14(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        if(voList.size() == 1) {
            dao.YACA021_INS_14(p_box, voList.get(0));
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC_14(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }

    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_INS_142(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        if(voList.size() == 1) {
            dao.YACA021_INS_142(p_box, voList.get(0));
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC_142(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }
    
    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_INS_15(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        if(voList.size() == 1) {
            dao.YACA021_INS_15(p_box, voList.get(0));
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC_15(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }
    
    
    
    /**
     *  개인간 주택임차차입금 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_PER(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PERSON");

        dao = new YACA021DAO(connectionName, p_tr);
        
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_PER(p_box, voList.get(0));
				dao.YACA021_UPT_FAM(p_box, voList.get(0));				
				break;
			case 3:
				// update;
				dao.YACA021_UPT_PER(p_box, voList.get(0));
				dao.YACA021_UPT_FAM(p_box, voList.get(0));					
				break;
			case 4:
				// delete;
				break;
			}
		}
    }    
    
    
    /**
     *  개인간 주택임차차입금 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_PER_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PERSON");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
        
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_PER_14(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_14(p_box, voList.get(0));				
				break;
			case 3:
				// update;
				dao.YACA021_UPT_PER_14(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_14(p_box, voList.get(0));					
				break;
			case 4:
				// delete;
				break;
			}
		}
    }    
    
    /**
     *  개인간 주택임차차입금 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_PER_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PERSON");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
        
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_PER_142(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_142(p_box, voList.get(0));				
				break;
			case 3:
				// update;
				dao.YACA021_UPT_PER_142(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_142(p_box, voList.get(0));					
				break;
			case 4:
				// delete;
				break;
			}
		}
    }   
    
    /**
     *  개인간 주택임차차입금 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_PER_15(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_PERSON");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
        
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			
			System.out.println("YACA021_SAV_PER_15::TX_MODE"+vo.getInt("TX_MODE"));
			
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_PER_15(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_15(p_box, voList.get(0));				
				break;
			case 3:
				// update;
				dao.YACA021_UPT_PER_15(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM_15(p_box, voList.get(0));					
				break;
			case 4:
				// delete;
				break;
			}
		}
    }     
    
    /**
     *  월세액 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_RENT(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RENT");

        dao = new YACA021DAO(connectionName, p_tr);
        
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_RENT(p_box, voList.get(0));
				dao.YACA021_UPT_FAM2(p_box, voList.get(0));						
				break;
			case 3:
				// update;
				dao.YACA021_UPT_RENT(p_box, voList.get(0));
				dao.YACA021_UPT_FAM2(p_box, voList.get(0));						
				break;
			case 4:
				// delete;
				break;
			}
		}
    }       
    
    
    /**
     *  월세액 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_RENT_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RENT");

        dao = new YACA021DAO(connectionName, p_tr);
        
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
     
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_RENT_14(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_14(p_box, voList.get(0));						
				break;
			case 3:
				// update;
				dao.YACA021_UPT_RENT_14(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_14(p_box, voList.get(0));						
				break;
			case 4:
				// delete;
				break;
			}
		}
    }           
    
    /**
     *  월세액 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_RENT_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RENT");

        dao = new YACA021DAO(connectionName, p_tr);
        
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
     
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_RENT_142(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_142(p_box, voList.get(0));						
				break;
			case 3:
				// update;
				dao.YACA021_UPT_RENT_142(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_142(p_box, voList.get(0));						
				break;
			case 4:
				// delete;
				break;
			}
		}
    }   
    
    /**
     *  월세액 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_SAV_RENT_15(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RENT");

        dao = new YACA021DAO(connectionName, p_tr);
        
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);
     
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			
			System.out.println("YACA021_SAV_RENT_15::TX_MODE::"+vo.getInt("TX_MODE"));
			switch (vo.getInt("TX_MODE")) {
			case 2:
				// insert;
				dao.YACA021_SAV_RENT_15(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_15(p_box, voList.get(0));						
				break;
			case 3:
				// update;
				dao.YACA021_UPT_RENT_15(p_box, voList.get(0));
				dao2.YACA021_UPT_FAM2_15(p_box, voList.get(0));						
				break;
			case 4:
				// delete;
				break;
			}
		}
    }   
    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_ACC(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        //변경 내역 반영
        this.YACA021_UPT_ACC(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }

    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_ACC_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        //변경 내역 반영
        this.YACA021_UPT_ACC_14(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }    
    
    
    /**
     *  새 항목을 등록한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_ACC_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        //변경 내역 반영
        this.YACA021_UPT_ACC_142(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }     
    
    /**
     *  새 항목을 수정한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        if(voList.size() == 1) {

            dao.YACA021_UPT(p_box, voList.get(0));
        }

        //변경 내역 반영
        this.YACA021_UPT_ACC_14(p_box, p_tr);
    }

    
    /**
     *  새 항목을 수정한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        if(voList.size() == 1) {

            dao.YACA021_UPT_14(p_box, voList.get(0));
        }

        //변경 내역 반영
        this.YACA021_UPT_ACC_14(p_box, p_tr);
    }    
    
    /**
     *  새 항목을 수정한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        if(voList.size() == 1) {

            dao.YACA021_UPT_142(p_box, voList.get(0));
        }

        //변경 내역 반영
        this.YACA021_UPT_ACC_142(p_box, p_tr);
    }       
    
    
    /**
     *  새 항목을 수정한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_15(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");

        dao = new YACA021DAO(connectionName, p_tr);
        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        if(voList.size() == 1) {

            dao.YACA021_UPT_15(p_box, voList.get(0));
        }

        //변경 내역 반영
        this.YACA021_UPT_ACC_15(p_box, p_tr);
    }    
    
    
    
    
    
    
    /**
     *  새 항목을 삭제한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_DEL(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");
        GauceValueObject vo = null;

        vo = voList.get(p_box.getInt("ROW_ID"));

        if(vo != null) {
            dao = new YACA021DAO(connectionName, p_tr);
            dao.YACA021_DEL(p_box, vo);
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }

    /**
     *  새 항목을 삭제한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_DEL_14(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");
        GauceValueObject vo = null;

        vo = voList.get(p_box.getInt("ROW_ID"));

        if(vo != null) {
            dao = new YACA021DAO(connectionName, p_tr);
            
            dao.YACA021_DEL_14(p_box, vo);
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC_14(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }    
    
    /**
     *  새 항목을 삭제한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_DEL_142(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");
        GauceValueObject vo = null;

        vo = voList.get(p_box.getInt("ROW_ID"));

        if(vo != null) {
            dao = new YACA021DAO(connectionName, p_tr);
            
            dao.YACA021_DEL_142(p_box, vo);
        }
        //변경 내역 반영
        this.YACA021_UPT_ACC_142(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }       
    
    /**
     *  새 항목을 삭제한다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_DEL_15(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_FAMILY");
        GauceValueObject vo = null;

        vo = voList.get(p_box.getInt("ROW_ID"));

        if(vo != null) {
            dao = new YACA021DAO(connectionName, p_tr);
            
            dao.YACA021_DEL_15(p_box, vo);
        }
        //변경 내역 반영
        //^^  좀있다가 수정 this.YACA021_UPT_ACC_15(p_box, p_tr);
        //this.YACA021_UPT_PERSON(p_box, p_tr);
    }       
    
    
    /**
     * 변경 내역 등록 (인사 마스터에 등록)
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_PERSON(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = null;
        GauceValueObject vo = null;

        dao = new YACA021DAO(connectionName, p_tr);

        int sou_cnt = 0;
        int dfm_cnt = 0;
        int gol_cnt70 = 0;
        int trb_cnt = 0;
        int wct_cnt = 0;
        int rch_cnt = 0;
        int chi_cnt = 0;
        int inp_cnt = 0;

        //부양가족 관련 내역을 계산해서 가져온다.
        voList = dao.YACA021_SHR_CNT(p_box);
        if(voList != null && voList.size() > 0) {
            vo = voList.get(0);

            sou_cnt     = vo.getInt("SOU_CNT"    );
            dfm_cnt     = vo.getInt("DFM_CNT"    );
            gol_cnt70   = vo.getInt("GOL_CNT70"  );
            trb_cnt     = vo.getInt("TRB_CNT"    );
            wct_cnt     = vo.getInt("WCT_CNT"    );
            rch_cnt     = vo.getInt("RCH_CNT"    );
            chi_cnt     = vo.getInt("CHI_CNT"    );
            inp_cnt     = vo.getInt("INP_CNT"    );
        }

        p_box.set("SOU_CNT"     ,sou_cnt      );
        p_box.set("DFM_CNT"     ,dfm_cnt      );
        p_box.set("GOL_CNT70"   ,gol_cnt70    );
        p_box.set("TRB_CNT"     ,trb_cnt      );
        p_box.set("WCT_CNT"     ,wct_cnt      );
        p_box.set("RCH_CNT"     ,rch_cnt      );
        p_box.set("CHI_CNT"     ,chi_cnt      );
        p_box.set("INP_CNT"     ,inp_cnt      );

        //dao.YACA021_UPT_PERSON(p_box);
    }

    
    
    /**
     * 변경 내역 등록
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_ACC(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        dao = new YACA021DAO(connectionName, p_tr);

        int chk_i = 0;
        int chk_j = 0;

        int sou_cnt = 0;
        int dfm_cnt = 0;
        int gol_cnt70 = 0;
        int trb_cnt = 0;
        int wct_cnt = 0;
        int rch_cnt = 0;
        int chi_cnt = 0;
        int inp_cnt = 0;


        int lin_amt = 0;
        int lih_amt = 0;
        int mhea_amt = 0;
        int lf2_amt = 0;
        int ohea_amt = 0;
        int len_amt = 0;
        int len_amt1 = 0;
        int len_amt2 = 0;
        int len_amt3 = 0;
        int len_amt4 = 0;
        int len_amt5 = 0;
        int edu_amt = 0;
        int gra_amt = 0;
        int edu_amt1 = 0;
        int edu_amt2 = 0;
        int edu_amt3 = 0;
        int edu_amt4 = 0;
        int edu_amt5 = 0;
        String edu_tag1 = null;
        String edu_tag2 = null;
        String edu_tag3 = null;
        String edu_tag4 = null;
        String edu_tag5 = null;

        int hed_amt = 0;
        
        int card_amt = 0;
        int dir_card_amt = 0;
        int cash_amt = 0;
        int market_amt = 0;        	//전통시장
        int public_amt = 0;			//학원비 지로납부액
        
        int lc1_amt = 0;				//기부금
        int lc2_amt = 0;
        int lc3_amt = 0;
        int lc4_amt = 0;

        int lh1_amt   = 0;//주택자금
        int lh2_amt04 = 0;
        int lh2_amt   = 0;
        int lh4_amt   = 0;
        int lh5_amt   = 0;
        int lh6_amt   = 0;
        int lh7_amt   = 0;
        int lh8_amt   = 0;
        
        String hol_yn = null;

        //기존 프로그램의 계산식 그대로 사용
        voList = dao.YACA021_SHR_ALL(p_box);

        for (int i = 0; i < voList.size(); i++) {
            vo = voList.get(i);


            if(vo.getString("BAS_MAN").equals("O")) {
                lin_amt = lin_amt + vo.getInt("LIN_AMT") + vo.getInt("LIN_AMT_NTS");
                lih_amt = lih_amt + vo.getInt("LIH_AMT") + vo.getInt("LIH_AMT_NTS");
            }

            if(vo.getString("REL_CD").equals("0")){
                mhea_amt = mhea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS");

                lh1_amt   = lh1_amt + vo.getInt("LH1_AMT") + vo.getInt("LH1_AMT_NTS");
                lh2_amt04 = lh2_amt04 + vo.getInt("LH2_AMT04") + vo.getInt("LH2_AMT04_NTS");
                lh2_amt   = lh2_amt + vo.getInt("LH2_AMT") + vo.getInt("LH2_AMT_NTS");
                lh4_amt   = lh4_amt + vo.getInt("LH4_AMT") + vo.getInt("LH4_AMT_NTS");
                lh5_amt   = lh5_amt + vo.getInt("LH5_AMT") + vo.getInt("LH5_AMT_NTS");
                lh6_amt   = lh6_amt + vo.getInt("LH6_AMT") + vo.getInt("LH6_AMT_NTS");
                lh7_amt   = lh7_amt + vo.getInt("LH7_AMT") + vo.getInt("LH7_AMT_NTS");
                lh8_amt   = lh8_amt + vo.getInt("LH8_AMT") + vo.getInt("LH8_AMT_NTS");
                
                hol_yn = vo.getString("HOL_YN");

            }else {
                if((vo.getString("GOL_70").equals("O")) || (vo.getString("GOL_65").equals("O"))
                        ||( vo.getString("TRB_MAN").equals("O"))){
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	   lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                      }else {
                       lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                      }
                }else{
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                	} else {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                	}
                }
            }

            if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") > 0) {
                len_amt = vo.getInt("LEN_AMT")+vo.getInt("LEN_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    len_amt1 = len_amt;

                }else{
                    chk_i++;
                    if(chk_i == 1){
                    	len_amt2 = len_amt;

                    }else if(chk_i == 2){
                    	len_amt3 = len_amt;

                    }else if(chk_i == 3){
                    	len_amt4 = len_amt;

                    }else if(chk_i == 4){
                    	len_amt5 = len_amt;
                    }
                }
            }

            if(vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS") > 0){
                edu_amt = vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    gra_amt = edu_amt;

                }else{
                    chk_j++;
                    if(chk_j == 1) {
                        edu_tag1 = vo.getString("EDU_TAG");
                        edu_amt1 = edu_amt;

                    } else if(chk_j == 2) {
                        edu_tag2 = vo.getString("EDU_TAG");
                        edu_amt2 = edu_amt;

                    } else if(chk_j == 3) {
                        edu_tag3 = vo.getString("EDU_TAG");
                        edu_amt3 = edu_amt;

                    } else if(chk_j == 4) {
                        edu_tag4 = vo.getString("EDU_TAG");
                        edu_amt4 = edu_amt;

                    } else if(chk_j == 5) {
                        edu_tag5 = vo.getString("EDU_TAG");
                        edu_amt5 = edu_amt;
                    }
                }
            }

            hed_amt  = hed_amt + vo.getInt("HED_AMT")+vo.getInt("HED_AMT_NTS");

            card_amt = card_amt + vo.getInt("CARD_AMT")+vo.getInt("CARD_AMT_NTS");
            dir_card_amt = dir_card_amt + vo.getInt("DIR_CARD_AMT")+vo.getInt("DIR_CARD_AMT_NTS");
            cash_amt = cash_amt + vo.getInt("CASH_AMT")+vo.getInt("CASH_AMT_NTS");
            market_amt  = market_amt + vo.getInt("MARKET_AMT")+vo.getInt("MARKET_AMT_NTS");            
            public_amt  = public_amt + vo.getInt("PUBLIC_AMT")+vo.getInt("PUBLIC_AMT_NTS");
            
            lc1_amt  = lc1_amt + vo.getInt("LC1_AMT");
            lc2_amt  = lc2_amt + vo.getInt("LC2_AMT");
            lc3_amt  = lc3_amt + vo.getInt("LC3_AMT")+vo.getInt("LC3_AMT_NTS");
            lc4_amt  = lc4_amt + vo.getInt("LC4_AMT");

        }

		//System.out.println(p_box);

        //부양가족 관련 내역을 계산해서 가져온다.
        voList = dao.YACA021_SHR_CNT(p_box);
        
        if(voList != null && voList.size() > 0) {
            vo = voList.get(0);

            sou_cnt     = vo.getInt("SOU_CNT"    );
            dfm_cnt     = vo.getInt("DFM_CNT"    );
            gol_cnt70   = vo.getInt("GOL_CNT70"  );
            trb_cnt     = vo.getInt("TRB_CNT"    );
            wct_cnt     = vo.getInt("WCT_CNT"    );
            rch_cnt     = vo.getInt("RCH_CNT"    );
            chi_cnt     = vo.getInt("CHI_CNT"    );
            inp_cnt     = vo.getInt("INP_CNT"    );
        }

        p_box.set("SOU_CNT"     ,sou_cnt      );
        p_box.set("DFM_CNT"     ,dfm_cnt      );
        p_box.set("GOL_CNT70"   ,gol_cnt70    );
        p_box.set("TRB_CNT"     ,trb_cnt      );
        p_box.set("WCT_CNT"     ,wct_cnt      );
        p_box.set("RCH_CNT"     ,rch_cnt      );
        p_box.set("CHI_CNT"     ,chi_cnt      );
        p_box.set("INP_CNT"     ,inp_cnt      );

        p_box.set("LIN_AMT"     ,lin_amt      );
        p_box.set("LIH_AMT"     ,lih_amt      );
        p_box.set("MHEA_AMT"    ,mhea_amt     );
        p_box.set("OHEA_AMT"    ,ohea_amt     );
        p_box.set("LF2_AMT"     ,lf2_amt      );
        p_box.set("LEN_AMT"     ,len_amt1     );
        p_box.set("LEN_AMT2"    ,len_amt2     );
        p_box.set("LEN_AMT3"    ,len_amt3     );
        p_box.set("LEN_AMT4"    ,len_amt4     );
        p_box.set("LEN_AMT5"    ,len_amt5     );
        p_box.set("EDU_TAG1"    ,edu_tag1     );
        p_box.set("EDU_TAG2"    ,edu_tag2     );
        p_box.set("EDU_TAG3"    ,edu_tag3     );
        p_box.set("EDU_TAG4"    ,edu_tag4     );
        p_box.set("EDU_TAG5"    ,edu_tag5     );
        p_box.set("EDU_AMT1"    ,edu_amt1     );
        p_box.set("EDU_AMT2"    ,edu_amt2     );
        p_box.set("EDU_AMT3"    ,edu_amt3     );
        p_box.set("EDU_AMT4"    ,edu_amt4     );
        p_box.set("EDU_AMT5"    ,edu_amt5     );
        p_box.set("GRA_AMT"     ,gra_amt      );
        p_box.set("HED_AMT"     ,hed_amt      );
        
        p_box.set("CARD_AMT"      ,card_amt      );
        p_box.set("DIR_CARD_AMT"  ,dir_card_amt      );
        p_box.set("CASH_AMT"      ,cash_amt      );
        p_box.set("MARKET_AMT"     ,market_amt     );        
        p_box.set("PUBLIC_AMT"     ,public_amt     );

        p_box.set("LC1_AMT"      ,lc1_amt      );
        p_box.set("LC2_AMT"      ,lc2_amt      );
        p_box.set("LC3_AMT"      ,lc3_amt      );
        p_box.set("LC4_AMT"      ,lc4_amt      );

        p_box.set("LH1_AMT"      ,lh1_amt      );
        p_box.set("LH2_AMT04"    ,lh2_amt04      );
        p_box.set("LH2_AMT"      ,lh2_amt      );
        p_box.set("LH4_AMT"      ,lh4_amt      );
        p_box.set("LH5_AMT"      ,lh5_amt      );
        p_box.set("LH6_AMT"      ,lh6_amt      );
        p_box.set("LH7_AMT"      ,lh7_amt      );
        p_box.set("LH8_AMT"      ,lh8_amt      );        
        p_box.set("HOL_YN", hol_yn);


        //변경 내역을 수정한다.
        dao.YACA021_UPT_ACC(p_box);
        //dao.YACA021_UPT_PERSON(p_box);
    }    
    
    
    
    
    /**
     * 변경 내역 등록
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_ACC_14(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        dao = new YACA021DAO(connectionName, p_tr);

        int chk_i = 0;
        int chk_j = 0;

        int sou_cnt = 0;
        int dfm_cnt = 0;
        int gol_cnt70 = 0;
        int trb_cnt = 0;
        int wct_cnt = 0;

        int lin_amt = 0;
        int lih_amt = 0;
        
        int mhea_amt = 0;
        int ohea_amt = 0;
        
        int len_amt = 0;
        int len_amt1 = 0;
        int len_amt2 = 0;
        int len_amt3 = 0;
        int len_amt4 = 0;
        int len_amt5 = 0;
        int edu_amt = 0;
        int gra_amt = 0;
        int edu_amt1 = 0;
        int edu_amt2 = 0;
        int edu_amt3 = 0;
        int edu_amt4 = 0;
        int edu_amt5 = 0;
        String edu_tag1 = null;
        String edu_tag2 = null;
        String edu_tag3 = null;
        String edu_tag4 = null;
        String edu_tag5 = null;

        int hed_amt = 0;
        
        int card_amt = 0;
        int dir_card_amt = 0;
        int cash_amt = 0;
        int market_amt = 0;        	//전통시장
        int public_amt = 0;			//대중교통

        int card_2013_amt = 0;
        int card_2014_amt = 0;
        int card_2013_over = 0;        	//
        int card_2014_over = 0;			//       

        int lc1_amt = 0;				//기부금
        int lc2_amt = 0;
        int lc3_amt = 0;

        int lh1_amt   = 0;//주택자금
        int lh2_amt = 0;
        int lh3_amt   = 0;
        int lh4_amt   = 0;
        int lh5_amt   = 0;
        int lh6_amt   = 0;
        int lh7_amt   = 0;
        int lh8_amt   = 0;
        
        int saju_amt = 0;					//우리사주          
        
        String hol_yn = null;

        //기존 프로그램의 계산식 그대로 사용
        voList = dao.YACA021_SHR_ALL_14(p_box);

        for (int i = 0; i < voList.size(); i++) {
            vo = voList.get(i);


            if(vo.getString("BAS_MAN").equals("O")) {
                lin_amt = lin_amt + vo.getInt("LIN_AMT") + vo.getInt("LIN_AMT_NTS");
                lih_amt = lih_amt + vo.getInt("LIH_AMT") + vo.getInt("LIH_AMT_NTS");
            }

            if(vo.getString("REL_CD").equals("0")){
            	
                mhea_amt = mhea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS");

                lh1_amt   = lh1_amt + vo.getInt("LH1_AMT") + vo.getInt("LH1_AMT_NTS");
                lh2_amt   = lh2_amt + vo.getInt("LH2_AMT") + vo.getInt("LH2_AMT_NTS");
                lh3_amt   = lh3_amt + vo.getInt("LH3_AMT") + vo.getInt("LH3_AMT_NTS");
                lh4_amt   = lh4_amt + vo.getInt("LH4_AMT") + vo.getInt("LH4_AMT_NTS");
                lh5_amt   = lh5_amt + vo.getInt("LH5_AMT") + vo.getInt("LH5_AMT_NTS");
                lh6_amt   = lh6_amt + vo.getInt("LH6_AMT") + vo.getInt("LH6_AMT_NTS");
                lh7_amt   = lh7_amt + vo.getInt("LH7_AMT") + vo.getInt("LH7_AMT_NTS");
                lh8_amt   = lh8_amt + vo.getInt("LH8_AMT") + vo.getInt("LH8_AMT_NTS");
                
                saju_amt   = saju_amt + vo.getInt("SAJU_AMT_NTS") + vo.getInt("SAJU_AMT");                
                
                hol_yn = vo.getString("HOL_YN");

            }else {
                if((vo.getString("GOL_70").equals("O")) || (vo.getString("GOL_65").equals("O")) ||( vo.getString("TRB_MAN").equals("O"))){
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	   //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                      }else {
                       //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                      }
                }else{
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                	} else {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                	}
                }
            }

            if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") > 0) {
                len_amt = vo.getInt("LEN_AMT")+vo.getInt("LEN_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    len_amt1 = len_amt;

                }else{
                    chk_i++;
                    if(chk_i == 1){
                    	len_amt2 = len_amt;

                    }else if(chk_i == 2){
                    	len_amt3 = len_amt;

                    }else if(chk_i == 3){
                    	len_amt4 = len_amt;

                    }else if(chk_i == 4){
                    	len_amt5 = len_amt;
                    }
                }
            }

            if(vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS") > 0){
                edu_amt = vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    gra_amt = edu_amt;

                }else{
                    chk_j++;
                    if(chk_j == 1) {
                        edu_tag1 = vo.getString("EDU_TAG");
                        edu_amt1 = edu_amt;

                    } else if(chk_j == 2) {
                        edu_tag2 = vo.getString("EDU_TAG");
                        edu_amt2 = edu_amt;

                    } else if(chk_j == 3) {
                        edu_tag3 = vo.getString("EDU_TAG");
                        edu_amt3 = edu_amt;

                    } else if(chk_j == 4) {
                        edu_tag4 = vo.getString("EDU_TAG");
                        edu_amt4 = edu_amt;

                    } else if(chk_j == 5) {
                        edu_tag5 = vo.getString("EDU_TAG");
                        edu_amt5 = edu_amt;
                    }
                }
            }

            hed_amt  = hed_amt + vo.getInt("HED_AMT")+vo.getInt("HED_AMT_NTS");

            card_amt 		= card_amt + vo.getInt("CARD_AMT")+vo.getInt("CARD_AMT_NTS");
            dir_card_amt 	= dir_card_amt + vo.getInt("DIR_CARD_AMT")+vo.getInt("DIR_CARD_AMT_NTS");
            cash_amt 		= cash_amt + vo.getInt("CASH_AMT")+vo.getInt("CASH_AMT_NTS");
            market_amt  	= market_amt + vo.getInt("MARKET_AMT")+vo.getInt("MARKET_AMT_NTS");      
            public_amt  	= public_amt + vo.getInt("PUBLIC_AMT")+vo.getInt("PUBLIC_AMT_NTS");

            card_2013_amt 		= card_2013_amt + vo.getInt("CARD_2013_AMT");
            card_2014_amt 		= card_2014_amt + vo.getInt("CARD_2014_AMT");
            card_2013_over 		= card_2013_over + vo.getInt("CARD_2013_OVER");
            card_2014_over 		= card_2014_over + vo.getInt("CARD_2014_OVER");            
            
            lc1_amt  = lc1_amt + vo.getInt("LC1_AMT");
            lc2_amt  = lc2_amt + vo.getInt("LC2_AMT");
            lc3_amt  = lc3_amt + vo.getInt("LC3_AMT");


        }

		//System.out.println("p_box 445555555555555555555555555555555555555555555554444"+p_box);

        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        //부양가족 관련 내역을 계산해서 가져온다.
        voList = dao2.YACA021_SHR_CNT_14(p_box);
        
        if(voList != null && voList.size() > 0) {
            vo = voList.get(0);

            sou_cnt     = vo.getInt("SOU_CNT"    );
            dfm_cnt     = vo.getInt("DFM_CNT"    );
            gol_cnt70   = vo.getInt("GOL_CNT70"  );
            trb_cnt     = vo.getInt("TRB_CNT"    );
            wct_cnt     = vo.getInt("WCT_CNT"    );

        }

        p_box.set("SOU_CNT"     ,sou_cnt      );
        p_box.set("DFM_CNT"      ,dfm_cnt      );
        p_box.set("GOL_CNT70"   ,gol_cnt70    );
        p_box.set("TRB_CNT"      ,trb_cnt      );
        p_box.set("WCT_CNT"     ,wct_cnt      );


        p_box.set("LIN_AMT"       ,lin_amt      );
        p_box.set("LIH_AMT"       ,lih_amt      );
        p_box.set("MHEA_AMT"    ,mhea_amt     );
        p_box.set("OHEA_AMT"    ,ohea_amt     );

        p_box.set("LEN_AMT"     ,len_amt1     );
        p_box.set("LEN_AMT2"    ,len_amt2     );
        p_box.set("LEN_AMT3"    ,len_amt3     );
        p_box.set("LEN_AMT4"    ,len_amt4     );
        p_box.set("LEN_AMT5"    ,len_amt5     );
        p_box.set("EDU_TAG1"    ,edu_tag1     );
        p_box.set("EDU_TAG2"    ,edu_tag2     );
        p_box.set("EDU_TAG3"    ,edu_tag3     );
        p_box.set("EDU_TAG4"    ,edu_tag4     );
        p_box.set("EDU_TAG5"    ,edu_tag5     );
        p_box.set("EDU_AMT1"    ,edu_amt1     );
        p_box.set("EDU_AMT2"    ,edu_amt2     );
        p_box.set("EDU_AMT3"    ,edu_amt3     );
        p_box.set("EDU_AMT4"    ,edu_amt4     );
        p_box.set("EDU_AMT5"    ,edu_amt5     );
        p_box.set("GRA_AMT"     ,gra_amt      );
        p_box.set("HED_AMT"     ,hed_amt      );
        
        p_box.set("CARD_AMT"        ,card_amt      );
        p_box.set("DIR_CARD_AMT"  ,dir_card_amt      );
        p_box.set("CASH_AMT"        ,cash_amt      );
        p_box.set("MARKET_AMT"     ,market_amt     );        
        p_box.set("PUBLIC_AMT"      ,public_amt     );       
        
        p_box.set("CARD_2013_AMT"        ,card_2013_amt      );
        p_box.set("CARD_2014_AMT"  		,card_2014_amt      );
        p_box.set("CARD_2013_OVER"        ,card_2013_over      );
        p_box.set("CARD_2014_OVER"     	,card_2014_over     );        

        p_box.set("LC1_AMT"      ,lc1_amt      );
        p_box.set("LC2_AMT"      ,lc2_amt      );
        p_box.set("LC3_AMT"      ,lc3_amt      );

        p_box.set("LH1_AMT"      ,lh1_amt      );
        p_box.set("LH2_AMT"      ,lh2_amt      );
        p_box.set("LH3_AMT"      ,lh3_amt      );
        p_box.set("LH4_AMT"      ,lh4_amt      );
        p_box.set("LH5_AMT"      ,lh5_amt      );
        p_box.set("LH6_AMT"      ,lh6_amt      );
        p_box.set("LH7_AMT"      ,lh7_amt      );
        p_box.set("LH8_AMT"      ,lh8_amt      );        

        p_box.set("SAJU_AMT"      ,saju_amt      );          
        
        p_box.set("HOL_YN"		   ,hol_yn);


        YACA021DAO dao3 = new YACA021DAO("default", p_tr);
        //변경 내역을 수정한다.
        dao3.YACA021_UPT_ACC_14(p_box);
        //dao.YACA021_UPT_PERSON(p_box);
    }
    
    
    /**
     * 변경 내역 등록
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_ACC_142(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        dao = new YACA021DAO(connectionName, p_tr);

        int chk_i = 0;
        int chk_j = 0;

        int sou_cnt = 0;
        int dfm_cnt = 0;
        int gol_cnt70 = 0;
        int trb_cnt = 0;
        int wct_cnt = 0;

        int lin_amt = 0;
        int lih_amt = 0;
        
        int mhea_amt = 0;
        int ohea_amt = 0;
        
        int len_amt = 0;
        int len_amt1 = 0;
        int len_amt2 = 0;
        int len_amt3 = 0;
        int len_amt4 = 0;
        int len_amt5 = 0;
        int edu_amt = 0;
        int gra_amt = 0;
        int edu_amt1 = 0;
        int edu_amt2 = 0;
        int edu_amt3 = 0;
        int edu_amt4 = 0;
        int edu_amt5 = 0;
        String edu_tag1 = null;
        String edu_tag2 = null;
        String edu_tag3 = null;
        String edu_tag4 = null;
        String edu_tag5 = null;

        int hed_amt = 0;
        
        int card_amt = 0;
        int dir_card_amt = 0;
        int cash_amt = 0;
        int market_amt = 0;        	//전통시장
        int public_amt = 0;			//대중교통

        int card_2013_amt = 0;
        int card_2014_amt = 0;
        int card_2013_over = 0;        	//
        int card_2014_over = 0;			//       

        int lc1_amt = 0;				//기부금
        int lc2_amt = 0;
        int lc3_amt = 0;

        int lh1_amt   = 0;//주택자금
        int lh2_amt = 0;
        int lh3_amt   = 0;
        int lh4_amt   = 0;
        int lh5_amt   = 0;
        int lh6_amt   = 0;
        int lh7_amt   = 0;
        int lh8_amt   = 0;
        
        int saju_amt = 0;					//우리사주          
        
        String hol_yn = null;

        //기존 프로그램의 계산식 그대로 사용
        voList = dao.YACA021_SHR_ALL_142(p_box);

        for (int i = 0; i < voList.size(); i++) {
            vo = voList.get(i);


            if(vo.getString("BAS_MAN").equals("O")) {
                lin_amt = lin_amt + vo.getInt("LIN_AMT") + vo.getInt("LIN_AMT_NTS");
                lih_amt = lih_amt + vo.getInt("LIH_AMT") + vo.getInt("LIH_AMT_NTS");
            }

            if(vo.getString("REL_CD").equals("0")){
            	
                mhea_amt = mhea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS");

                lh1_amt   = lh1_amt + vo.getInt("LH1_AMT") + vo.getInt("LH1_AMT_NTS");
                lh2_amt   = lh2_amt + vo.getInt("LH2_AMT") + vo.getInt("LH2_AMT_NTS");
                lh3_amt   = lh3_amt + vo.getInt("LH3_AMT") + vo.getInt("LH3_AMT_NTS");
                lh4_amt   = lh4_amt + vo.getInt("LH4_AMT") + vo.getInt("LH4_AMT_NTS");
                lh5_amt   = lh5_amt + vo.getInt("LH5_AMT") + vo.getInt("LH5_AMT_NTS");
                lh6_amt   = lh6_amt + vo.getInt("LH6_AMT") + vo.getInt("LH6_AMT_NTS");
                lh7_amt   = lh7_amt + vo.getInt("LH7_AMT") + vo.getInt("LH7_AMT_NTS");
                lh8_amt   = lh8_amt + vo.getInt("LH8_AMT") + vo.getInt("LH8_AMT_NTS");
                
                saju_amt   = saju_amt + vo.getInt("SAJU_AMT_NTS") + vo.getInt("SAJU_AMT");                
                
                hol_yn = vo.getString("HOL_YN");

            }else {
                if((vo.getString("GOL_70").equals("O")) || (vo.getString("GOL_65").equals("O")) ||( vo.getString("TRB_MAN").equals("O"))){
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	   //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                      }else {
                       //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                      }
                }else{
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                	} else {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                	}
                }
            }

            if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") > 0) {
                len_amt = vo.getInt("LEN_AMT")+vo.getInt("LEN_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    len_amt1 = len_amt;

                }else{
                    chk_i++;
                    if(chk_i == 1){
                    	len_amt2 = len_amt;

                    }else if(chk_i == 2){
                    	len_amt3 = len_amt;

                    }else if(chk_i == 3){
                    	len_amt4 = len_amt;

                    }else if(chk_i == 4){
                    	len_amt5 = len_amt;
                    }
                }
            }

            if(vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS") > 0){
                edu_amt = vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    gra_amt = edu_amt;

                }else{
                    chk_j++;
                    if(chk_j == 1) {
                        edu_tag1 = vo.getString("EDU_TAG");
                        edu_amt1 = edu_amt;

                    } else if(chk_j == 2) {
                        edu_tag2 = vo.getString("EDU_TAG");
                        edu_amt2 = edu_amt;

                    } else if(chk_j == 3) {
                        edu_tag3 = vo.getString("EDU_TAG");
                        edu_amt3 = edu_amt;

                    } else if(chk_j == 4) {
                        edu_tag4 = vo.getString("EDU_TAG");
                        edu_amt4 = edu_amt;

                    } else if(chk_j == 5) {
                        edu_tag5 = vo.getString("EDU_TAG");
                        edu_amt5 = edu_amt;
                    }
                }
            }

            hed_amt  = hed_amt + vo.getInt("HED_AMT")+vo.getInt("HED_AMT_NTS");

            card_amt 		= card_amt + vo.getInt("CARD_AMT")+vo.getInt("CARD_AMT_NTS");
            dir_card_amt 	= dir_card_amt + vo.getInt("DIR_CARD_AMT")+vo.getInt("DIR_CARD_AMT_NTS");
            cash_amt 		= cash_amt + vo.getInt("CASH_AMT")+vo.getInt("CASH_AMT_NTS");
            market_amt  	= market_amt + vo.getInt("MARKET_AMT")+vo.getInt("MARKET_AMT_NTS");      
            public_amt  	= public_amt + vo.getInt("PUBLIC_AMT")+vo.getInt("PUBLIC_AMT_NTS");

            card_2013_amt 		= card_2013_amt + vo.getInt("CARD_2013_AMT");
            card_2014_amt 		= card_2014_amt + vo.getInt("CARD_2014_AMT");
            card_2013_over 		= card_2013_over + vo.getInt("CARD_2013_OVER");
            card_2014_over 		= card_2014_over + vo.getInt("CARD_2014_OVER");            
            
            lc1_amt  = lc1_amt + vo.getInt("LC1_AMT");
            lc2_amt  = lc2_amt + vo.getInt("LC2_AMT");
            lc3_amt  = lc3_amt + vo.getInt("LC3_AMT");


        }

		//System.out.println("p_box 445555555555555555555555555555555555555555555554444"+p_box);

        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        //부양가족 관련 내역을 계산해서 가져온다.
        voList = dao2.YACA021_SHR_CNT_142(p_box);
        
        if(voList != null && voList.size() > 0) {
            vo = voList.get(0);

            sou_cnt     = vo.getInt("SOU_CNT"    );
            dfm_cnt     = vo.getInt("DFM_CNT"    );
            gol_cnt70   = vo.getInt("GOL_CNT70"  );
            trb_cnt     = vo.getInt("TRB_CNT"    );
            wct_cnt     = vo.getInt("WCT_CNT"    );

        }

        p_box.set("SOU_CNT"     ,sou_cnt      );
        p_box.set("DFM_CNT"      ,dfm_cnt      );
        p_box.set("GOL_CNT70"   ,gol_cnt70    );
        p_box.set("TRB_CNT"      ,trb_cnt      );
        p_box.set("WCT_CNT"     ,wct_cnt      );


        p_box.set("LIN_AMT"       ,lin_amt      );
        p_box.set("LIH_AMT"       ,lih_amt      );
        p_box.set("MHEA_AMT"    ,mhea_amt     );
        p_box.set("OHEA_AMT"    ,ohea_amt     );

        p_box.set("LEN_AMT"     ,len_amt1     );
        p_box.set("LEN_AMT2"    ,len_amt2     );
        p_box.set("LEN_AMT3"    ,len_amt3     );
        p_box.set("LEN_AMT4"    ,len_amt4     );
        p_box.set("LEN_AMT5"    ,len_amt5     );
        p_box.set("EDU_TAG1"    ,edu_tag1     );
        p_box.set("EDU_TAG2"    ,edu_tag2     );
        p_box.set("EDU_TAG3"    ,edu_tag3     );
        p_box.set("EDU_TAG4"    ,edu_tag4     );
        p_box.set("EDU_TAG5"    ,edu_tag5     );
        p_box.set("EDU_AMT1"    ,edu_amt1     );
        p_box.set("EDU_AMT2"    ,edu_amt2     );
        p_box.set("EDU_AMT3"    ,edu_amt3     );
        p_box.set("EDU_AMT4"    ,edu_amt4     );
        p_box.set("EDU_AMT5"    ,edu_amt5     );
        p_box.set("GRA_AMT"     ,gra_amt      );
        p_box.set("HED_AMT"     ,hed_amt      );
        
        p_box.set("CARD_AMT"        ,card_amt      );
        p_box.set("DIR_CARD_AMT"  ,dir_card_amt      );
        p_box.set("CASH_AMT"        ,cash_amt      );
        p_box.set("MARKET_AMT"     ,market_amt     );        
        p_box.set("PUBLIC_AMT"      ,public_amt     );       
        
        p_box.set("CARD_2013_AMT"        ,card_2013_amt      );
        p_box.set("CARD_2014_AMT"  		,card_2014_amt      );
        p_box.set("CARD_2013_OVER"        ,card_2013_over      );
        p_box.set("CARD_2014_OVER"     	,card_2014_over     );        

        p_box.set("LC1_AMT"      ,lc1_amt      );
        p_box.set("LC2_AMT"      ,lc2_amt      );
        p_box.set("LC3_AMT"      ,lc3_amt      );

        p_box.set("LH1_AMT"      ,lh1_amt      );
        p_box.set("LH2_AMT"      ,lh2_amt      );
        p_box.set("LH3_AMT"      ,lh3_amt      );
        p_box.set("LH4_AMT"      ,lh4_amt      );
        p_box.set("LH5_AMT"      ,lh5_amt      );
        p_box.set("LH6_AMT"      ,lh6_amt      );
        p_box.set("LH7_AMT"      ,lh7_amt      );
        p_box.set("LH8_AMT"      ,lh8_amt      );        

        p_box.set("SAJU_AMT"      ,saju_amt      );          
        
        p_box.set("HOL_YN"		   ,hol_yn);


        YACA021DAO dao3 = new YACA021DAO("default", p_tr);
        //변경 내역을 수정한다.
        dao3.YACA021_UPT_ACC_142(p_box);
        //dao.YACA021_UPT_PERSON(p_box);
    }
     
    /**
     * 변경 내역 등록
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA021_UPT_ACC_15(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        dao = new YACA021DAO(connectionName, p_tr);

        int chk_i = 0;
        int chk_j = 0;

        int sou_cnt = 0;
        int dfm_cnt = 0;
        int gol_cnt70 = 0;
        int trb_cnt = 0;
        int wct_cnt = 0;
        int inp_cnt = 0;
        int rch_cnt = 0;

        int lin_amt = 0;
        int lih_amt = 0;
        
        int mhea_amt = 0;
        int ohea_amt = 0;
        
        int len_amt = 0;
        int len_amt1 = 0;
        int len_amt2 = 0;
        int len_amt3 = 0;
        int len_amt4 = 0;
        int len_amt5 = 0;
        int edu_amt = 0;
        int gra_amt = 0;
        int edu_amt1 = 0;
        int edu_amt2 = 0;
        int edu_amt3 = 0;
        int edu_amt4 = 0;
        int edu_amt5 = 0;
        String edu_tag1 = null;
        String edu_tag2 = null;
        String edu_tag3 = null;
        String edu_tag4 = null;
        String edu_tag5 = null;

        int hed_amt = 0;
        
        int card_amt = 0;
        int dir_card_amt = 0;
        int cash_amt = 0;
        int market_amt = 0;        	//전통시장
        int public_amt = 0;			//대중교통

        int card_2013_amt = 0;
        int card_2014_amt = 0;
        int card_2013_over = 0;        	//
        int card_2014_over = 0;			//     
        int card_2015_amt = 0;			//     
        int card_2015_fh_over = 0;			//     
        int card_2015_sh_over = 0;			//     

        int lc1_amt = 0;				//기부금
        int lc2_amt = 0;
        int lc3_amt = 0;

        int lh1_amt   = 0;//주택자금
        int lh2_amt   = 0;
        int lh3_amt   = 0;
        int lh4_amt   = 0;
        int lh5_amt   = 0;
        int lh6_amt   = 0;
        int lh7_amt   = 0;
        int lh8_amt   = 0;
        int lh9_amt   = 0;
        int lh10_amt  = 0;
        int lh11_amt  = 0;
        int lh12_amt  = 0;
        
        int saju_amt = 0;					//우리사주          
        
        String hol_yn = null;
        String ins_tag= null;

        //기존 프로그램의 계산식 그대로 사용
        voList = dao.YACA021_SHR_ALL_15(p_box);

        for (int i = 0; i < voList.size(); i++) {
            vo = voList.get(i);


            if(vo.getString("BAS_MAN").equals("O")) {
                lin_amt = lin_amt + vo.getInt("LIN_AMT") + vo.getInt("LIN_AMT_NTS");
                lih_amt = lih_amt + vo.getInt("LIH_AMT") + vo.getInt("LIH_AMT_NTS");
            }

            if(vo.getString("REL_CD").equals("0")){
            	
                mhea_amt = mhea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS");

                lh1_amt   = lh1_amt + vo.getInt("LH1_AMT") + vo.getInt("LH1_AMT_NTS");
                lh2_amt   = lh2_amt + vo.getInt("LH2_AMT") + vo.getInt("LH2_AMT_NTS");
                lh3_amt   = lh3_amt + vo.getInt("LH3_AMT") + vo.getInt("LH3_AMT_NTS");
                lh4_amt   = lh4_amt + vo.getInt("LH4_AMT") + vo.getInt("LH4_AMT_NTS");
                lh5_amt   = lh5_amt + vo.getInt("LH5_AMT") + vo.getInt("LH5_AMT_NTS");
                lh6_amt   = lh6_amt + vo.getInt("LH6_AMT") + vo.getInt("LH6_AMT_NTS");
                lh7_amt   = lh7_amt + vo.getInt("LH7_AMT") + vo.getInt("LH7_AMT_NTS");
                lh8_amt   = lh8_amt + vo.getInt("LH8_AMT") + vo.getInt("LH8_AMT_NTS");
                lh9_amt   = lh9_amt + vo.getInt("LH9_AMT") + vo.getInt("LH9_AMT_NTS");
                lh10_amt  = lh10_amt+ vo.getInt("LH10_AMT")+ vo.getInt("LH10_AMT_NTS");
                lh11_amt  = lh11_amt+ vo.getInt("LH11_AMT")+ vo.getInt("LH11_AMT_NTS");
                lh12_amt  = lh12_amt+ vo.getInt("LH12_AMT")+ vo.getInt("LH12_AMT_NTS");
                
                saju_amt   = saju_amt + vo.getInt("SAJU_AMT_NTS") + vo.getInt("SAJU_AMT");                
                
                hol_yn = vo.getString("HOL_YN");
                ins_tag = vo.getString("INS_TAG");

            }else {
                if((vo.getString("GOL_70").equals("O")) || (vo.getString("GOL_65").equals("O")) ||( vo.getString("TRB_MAN").equals("O"))){
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	   //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                      }else {
                       //lf2_amt = lf2_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                      }
                }else{
                	if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") <= 500000) {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS");
                	} else {
                	 ohea_amt = ohea_amt + vo.getInt("MED_AMT") + vo.getInt("MED_AMT_NTS") + 500000;
                	}
                }
            }

            if(vo.getInt("LEN_AMT") + vo.getInt("LEN_AMT_NTS") > 0) {
                len_amt = vo.getInt("LEN_AMT")+vo.getInt("LEN_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    len_amt1 = len_amt;

                }else{
                    chk_i++;
                    if(chk_i == 1){
                    	len_amt2 = len_amt;

                    }else if(chk_i == 2){
                    	len_amt3 = len_amt;

                    }else if(chk_i == 3){
                    	len_amt4 = len_amt;

                    }else if(chk_i == 4){
                    	len_amt5 = len_amt;
                    }
                }
            }

            if(vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS") > 0){
                edu_amt = vo.getInt("EDU_AMT") + vo.getInt("EDU_AMT_NTS");

                if(vo.getString("REL_CD").equals("0")){//숫자
                    gra_amt = edu_amt;

                }else{
                    chk_j++;
                    if(chk_j == 1) {
                        edu_tag1 = vo.getString("EDU_TAG");
                        edu_amt1 = edu_amt;

                    } else if(chk_j == 2) {
                        edu_tag2 = vo.getString("EDU_TAG");
                        edu_amt2 = edu_amt;

                    } else if(chk_j == 3) {
                        edu_tag3 = vo.getString("EDU_TAG");
                        edu_amt3 = edu_amt;

                    } else if(chk_j == 4) {
                        edu_tag4 = vo.getString("EDU_TAG");
                        edu_amt4 = edu_amt;

                    } else if(chk_j == 5) {
                        edu_tag5 = vo.getString("EDU_TAG");
                        edu_amt5 = edu_amt;
                    }
                }
            }

            hed_amt  = hed_amt + vo.getInt("HED_AMT")+vo.getInt("HED_AMT_NTS");

            card_amt 		= card_amt + vo.getInt("CARD_AMT")+vo.getInt("CARD_AMT_NTS");
            dir_card_amt 	= dir_card_amt + vo.getInt("DIR_CARD_AMT")+vo.getInt("DIR_CARD_AMT_NTS");
            cash_amt 		= cash_amt + vo.getInt("CASH_AMT")+vo.getInt("CASH_AMT_NTS");
            market_amt  	= market_amt + vo.getInt("MARKET_AMT")+vo.getInt("MARKET_AMT_NTS");      
            public_amt  	= public_amt + vo.getInt("PUBLIC_AMT")+vo.getInt("PUBLIC_AMT_NTS");

            card_2013_amt 		= card_2013_amt + vo.getInt("CARD_2013_AMT");
            card_2014_amt 		= card_2014_amt + vo.getInt("CARD_2014_AMT");
            card_2013_over 		= card_2013_over + vo.getInt("CARD_2013_OVER");
            card_2014_over 		= card_2014_over + vo.getInt("CARD_2014_OVER");  
            
            card_2015_amt 		= card_2015_amt + vo.getInt("CARD_2015_AMT");  
            card_2015_fh_over 	= card_2015_fh_over + vo.getInt("CARD_2015_FH_OVER");  
            card_2015_sh_over 	= card_2015_sh_over + vo.getInt("CARD_2015_SH_OVER");  
            
            lc1_amt  = lc1_amt + vo.getInt("LC1_AMT");
            lc2_amt  = lc2_amt + vo.getInt("LC2_AMT");
            lc3_amt  = lc3_amt + vo.getInt("LC3_AMT");


        }

		//System.out.println("p_box 445555555555555555555555555555555555555555555554444"+p_box);

        YACA021DAO dao2 = new YACA021DAO("default", p_tr);

        //부양가족 관련 내역을 계산해서 가져온다.
        voList = dao2.YACA021_SHR_CNT_15(p_box);
        
        if(voList != null && voList.size() > 0) {
            vo = voList.get(0);
         
            sou_cnt     = vo.getInt("SOU_CNT"    );
            dfm_cnt     = vo.getInt("DFM_CNT"    );
            gol_cnt70   = vo.getInt("GOL_CNT70"  );
            trb_cnt     = vo.getInt("TRB_CNT"    );
            wct_cnt     = vo.getInt("WCT_CNT"    );
            inp_cnt     = vo.getInt("INP_CNT"    );
            rch_cnt     = vo.getInt("RCH_CNT"    );

        }

        p_box.set("SOU_CNT"     ,sou_cnt      );
        p_box.set("DFM_CNT"     ,dfm_cnt      );
        p_box.set("GOL_CNT70"   ,gol_cnt70    );
        p_box.set("TRB_CNT"     ,trb_cnt      );
        p_box.set("WCT_CNT"     ,wct_cnt      );
        p_box.set("INP_CNT"     ,inp_cnt      ); //추가
        p_box.set("RCH_CNT"     ,rch_cnt      ); //추가


        p_box.set("LIN_AMT"     ,lin_amt      );
        p_box.set("LIH_AMT"     ,lih_amt      );
        p_box.set("MHEA_AMT"    ,mhea_amt     );
        p_box.set("OHEA_AMT"    ,ohea_amt     );

        p_box.set("LEN_AMT"     ,len_amt1     );
        p_box.set("LEN_AMT2"    ,len_amt2     );
        p_box.set("LEN_AMT3"    ,len_amt3     );
        p_box.set("LEN_AMT4"    ,len_amt4     );
        p_box.set("LEN_AMT5"    ,len_amt5     );
        p_box.set("EDU_TAG1"    ,edu_tag1     );
        p_box.set("EDU_TAG2"    ,edu_tag2     );
        p_box.set("EDU_TAG3"    ,edu_tag3     );
        p_box.set("EDU_TAG4"    ,edu_tag4     );
        p_box.set("EDU_TAG5"    ,edu_tag5     );
        p_box.set("EDU_AMT1"    ,edu_amt1     );
        p_box.set("EDU_AMT2"    ,edu_amt2     );
        p_box.set("EDU_AMT3"    ,edu_amt3     );
        p_box.set("EDU_AMT4"    ,edu_amt4     );
        p_box.set("EDU_AMT5"    ,edu_amt5     );
        p_box.set("GRA_AMT"     ,gra_amt      );
        p_box.set("HED_AMT"     ,hed_amt      );
        
        p_box.set("CARD_AMT"     ,card_amt      );
        p_box.set("DIR_CARD_AMT" ,dir_card_amt  );
        p_box.set("CASH_AMT"     ,cash_amt      );
        p_box.set("MARKET_AMT"   ,market_amt    );        
        p_box.set("PUBLIC_AMT"   ,public_amt    );       
        
        p_box.set("CARD_2013_AMT"       ,card_2013_amt      );
        p_box.set("CARD_2014_AMT"  		,card_2014_amt      );
        p_box.set("CARD_2013_OVER"      ,card_2013_over     );
        p_box.set("CARD_2014_OVER"     	,card_2014_over     );    
        p_box.set("CARD_2015_AMT"     	,card_2015_amt      );    
        p_box.set("CARD_2015_FH_OVER"   ,card_2015_fh_over     );    
        p_box.set("CARD_2015_SH_OVER"   ,card_2015_sh_over     );    

        p_box.set("LC1_AMT"      ,lc1_amt      );
        p_box.set("LC2_AMT"      ,lc2_amt      );
        p_box.set("LC3_AMT"      ,lc3_amt      );

        p_box.set("LH1_AMT"      ,lh1_amt      );
        p_box.set("LH2_AMT"      ,lh2_amt      );
        p_box.set("LH3_AMT"      ,lh3_amt      );
        p_box.set("LH4_AMT"      ,lh4_amt      );
        p_box.set("LH5_AMT"      ,lh5_amt      );
        p_box.set("LH6_AMT"      ,lh6_amt      );
        p_box.set("LH7_AMT"      ,lh7_amt      );
        p_box.set("LH8_AMT"      ,lh8_amt      );
        p_box.set("LH9_AMT"      ,lh9_amt      );
        p_box.set("LH10_AMT"     ,lh10_amt     );
        p_box.set("LH11_AMT"     ,lh11_amt     );
        p_box.set("LH12_AMT"     ,lh12_amt     );

        p_box.set("SAJU_AMT"     ,saju_amt     );          
        
        p_box.set("HOL_YN"		 ,hol_yn       );
        p_box.set("INS_TAG"		 ,ins_tag      );


        YACA021DAO dao3 = new YACA021DAO("default", p_tr);
        //변경 내역을 수정한다.
        dao3.YACA021_UPT_ACC_15(p_box);
        //dao.YACA021_UPT_PERSON(p_box);
    }
     

    
}




