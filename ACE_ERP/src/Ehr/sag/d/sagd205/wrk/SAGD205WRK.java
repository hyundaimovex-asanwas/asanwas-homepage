package Ehr.sag.d.sagd205.wrk;

import Ehr.sag.d.sagd205.dao.SAGD205DAO;

import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.exception.DuplicateKeyException;
import com.shift.gef.core.exception.SysException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.FileUtil;
import Ehr.common.util.JSPUtil;
import Ehr.common.util.POIUtil;

public class SAGD205WRK {

	/**
	 * 급여테이블 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD205_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD205DAO dao = new SAGD205DAO("default", p_tr);
		SAGD205DAO dao2 = new SAGD205DAO("default", p_tr);		
		
		dao.SAGD205_SHR(p_box);
		
		/** 개인정보처리 접속 기록  **/
		dao2.SAGD205_SHR_ACC(p_box);
		
	}

	/**
	 * 소급 급여 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD205_SHR_SO(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD205DAO dao = new SAGD205DAO("default", p_tr);
		dao.SAGD205_SHR_SO(p_box);

	}

	/**
	 * 급여테이블 적용일자 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD205_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD205DAO dao = new SAGD205DAO("default", p_tr);
		dao.SAGD205_SHR_01(p_box);

	}

	/**
	 * 출력용도 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD205_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGD205DAO dao = new SAGD205DAO("default", p_tr);
		dao.SAGD205_SHR_PRINT(p_box);

	}




}
