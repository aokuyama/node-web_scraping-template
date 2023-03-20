import { launchChromium } from "playwright-aws-lambda";
import { ChromiumBrowser } from "playwright-core";

export const handler = async (event: any) => {
  console.debug(event);

  let browser: ChromiumBrowser | null = null;
  try {
    browser = await launchChromium({ headless: true });
    const context = await browser.newContext();
    const page = await context.newPage();

    await page.goto("https://example.com/");
    const h1 = page.locator("h1");
    console.log(await h1.innerText());
  } catch (error) {
    console.error(error);
    throw error;
  } finally {
    if (browser) {
      await browser.close();
    }
  }
};
