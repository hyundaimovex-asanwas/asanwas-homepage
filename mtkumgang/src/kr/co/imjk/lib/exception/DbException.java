package kr.co.imjk.lib.exception;

import kr.co.imjk.util.Util;

public class DbException extends Exception {

  public DbException() {
    super();
  }

  public DbException(Throwable e) {
    //System.out.println(Util.getStackTrace(e));
  }
  
  public DbException(String msg) {
    super(msg);
    //System.out.println(Util.getStackTrace(this));
  }
}
