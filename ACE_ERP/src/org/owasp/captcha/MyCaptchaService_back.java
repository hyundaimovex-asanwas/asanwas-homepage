package org.owasp.captcha;

import com.octo.captcha.service.image.ImageCaptchaService;
import com.octo.captcha.service.image.DefaultManageableImageCaptchaService;

public class MyCaptchaService_back
{
  // a singleton class
  private static ImageCaptchaService instance = new DefaultManageableImageCaptchaService();

  public static ImageCaptchaService getInstance()
  {
    return instance;
  }
}