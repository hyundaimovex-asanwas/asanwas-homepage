package Ehr.vlu.l.vlul060.ejb;

import hr.vlu.l.vlul060.wrk.VLUL060WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class VLUL060EJB extends EJB {

	public CBox box = null;
    public TrBox trBox = null;
    public VLUL060EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUL060WRK wrk = new VLUL060WRK();

		if (box.get("S_MODE").equals("SHR")) {
			wrk.VLUL060_SHR(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_PJT")) {
            wrk.VLUL060_SHR_PJT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_DPT")) {
            wrk.VLUL060_SHR_DPT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_CON")) {
            wrk.VLUL060_SHR_CON(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUL060_SHR_01(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUL060_SHR_02(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_02_PJT")) {
            wrk.VLUL060_SHR_02_PJT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_02_DPT")) {
            wrk.VLUL060_SHR_02_DPT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_02_CON")) {
            wrk.VLUL060_SHR_02_CON(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUL060_SHR_03(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_04")) {
            wrk.VLUL060_SHR_04(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_04_PJT")) {
            wrk.VLUL060_SHR_04_PJT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_04_DPT")) {
            wrk.VLUL060_SHR_04_DPT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_04_CON")) {
            wrk.VLUL060_SHR_04_CON(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_05")) {
            wrk.VLUL060_SHR_05(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_06")) {
            wrk.VLUL060_SHR_06(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_06_PJT")) {
            wrk.VLUL060_SHR_06_PJT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_06_DPT")) {
            wrk.VLUL060_SHR_06_DPT(box, trBox);
		}else  if (box.get("S_MODE").equals("SHR_06_CON")) {
            wrk.VLUL060_SHR_06_CON(box, trBox);    
		}else  if (box.get("S_MODE").equals("SHR_07")) {
            wrk.VLUL060_SHR_07(box, trBox);
		}else  if (box.get("S_MODE").equals("SAV")) {
            wrk.VLUL060_SAV(box, trBox);
		}else  if (box.get("S_MODE").equals("SAV_EXE")) {
            wrk.VLUL060_SAV_EXE(box, trBox);
		}else  if (box.get("S_MODE").equals("SAV_GRD")) {
            wrk.VLUL060_SAV_GRD(box, trBox);
		}

		return null;
	}

}
