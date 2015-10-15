package  {
	import com.pozirk.payment.android.InAppPurchase;
	import com.pozirk.payment.android.InAppPurchaseEvent;
	import com.pozirk.payment.android.InAppPurchaseDetails;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	
	public  class InAppHandler extends MovieClip {
		
		var _iap:InAppPurchase = null ;
		var _producID:String = "" ;
		var _purchase:InAppPurchaseDetails = null ;
		
		public  function InAppHandler() {
			
		}


		//initializ
		protected  function initInApp(key:String) {
			_iap = new InAppPurchase(); 
			//initialization of InAppPurchase
			_iap.addEventListener(InAppPurchaseEvent.INIT_SUCCESS, onInitSuccess);
			_iap.addEventListener(InAppPurchaseEvent.INIT_ERROR, onInitError);
			// کلید RSA
			_iap.init(key);
		}

		protected  function onInitSuccess(event:InAppPurchaseEvent):void
		{
			trace( "InAppBilling supported" );
			//you can restore previously purchased items here
		}
		protected  function onInitError(event:InAppPurchaseEvent):void
		{
			trace( "InAppBilling not supported" );
			trace(event.data); //trace error message
		}
		
		
		//restor
		protected  function restoreInApp(producID:String){
			_iap.removeEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, onRestoreConsumeSuccess);
			_iap.removeEventListener(InAppPurchaseEvent.RESTORE_ERROR, onRestoreConsumeError);
			_iap.removeEventListener(InAppPurchaseEvent.CONSUME_SUCCESS, onConsumeSuccess);
			_iap.removeEventListener(InAppPurchaseEvent.CONSUME_ERROR, onConsumeError);

			_iap.addEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, onRestoreSuccess);
			_iap.addEventListener(InAppPurchaseEvent.RESTORE_ERROR, onRestoreError);
			_producID = producID ;
			_iap.restore();
		}
		
		protected function onRestoreSuccess(event:InAppPurchaseEvent)
		{
			_purchase = _iap.getPurchaseDetails(_producID);
			if(_purchase != null ){
				trace (_purchase._json);
				//trace (_purchase._orderId);
				//trace (_purchase._packageName);
				//trace (_purchase._payload);
				//trace (_purchase._purchaseState);
				//trace (_purchase._signature);
				//trace (_purchase._sku);
				//trace (_purchase._time);
				//trace (_purchase._token);
				//trace (_purchase._type);
			}  
		}
		protected function onRestoreError(event:InAppPurchaseEvent):void
		{
			trace( "restore Failed" );
		}
		
		
		
		//purchase
		protected  function purchaseInApp(producID:String){
			_iap.addEventListener(InAppPurchaseEvent.PURCHASE_SUCCESS, onPurchaseSuccess);
			_iap.addEventListener(InAppPurchaseEvent.PURCHASE_ERROR, onPurchaseError);
			_iap.purchase(producID, InAppPurchaseDetails.TYPE_INAPP);
		}
		protected function onPurchaseSuccess(event:InAppPurchaseEvent):void
		{
			trace("Purchase Success");
 			trace(event.data); //product id
		}

		protected function onPurchaseError(event:InAppPurchaseEvent):void
		{
 		   trace(event.data); //trace error message
		}		
		
		
		
		//Consome
		protected function consumeInApp(producID:String)
		{
			_iap.addEventListener(InAppPurchaseEvent.RESTORE_SUCCESS, onRestoreConsumeSuccess);
			_iap.addEventListener(InAppPurchaseEvent.RESTORE_ERROR, onRestoreConsumeError);
			_producID = producID ;
			_iap.restore();
		}

		protected function onRestoreConsumeSuccess(event:InAppPurchaseEvent)
		{
			_iap.addEventListener(InAppPurchaseEvent.CONSUME_SUCCESS, onConsumeSuccess);
			_iap.addEventListener(InAppPurchaseEvent.CONSUME_ERROR, onConsumeError);
			_iap.consume(_producID);
		}
		protected function onRestoreConsumeError(event:InAppPurchaseEvent):void
		{
			trace( "restoreConsome Failed" );
		}
		
		protected function onConsumeSuccess(event:InAppPurchaseEvent):void
		{
 		   trace("Consume Success"); 
		}
				protected function onConsumeError(event:InAppPurchaseEvent):void
		{
		    trace("Consume Failed"); 
		}
		
		
		
		
		//Distore
		protected function disposeInApp()
		{
			_iap.dispose();
			trace("Dispose");
		}
		
	}
	
}
