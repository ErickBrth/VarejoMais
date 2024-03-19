package com.example.varejo_mais;


import br.com.positivo.api.cipurse.Cipurse;
import br.com.positivo.api.installer.Installer;
import br.com.positivo.api.mifare.Mifare;
import br.com.positivo.api.network.Network;
import br.com.positivo.api.settings.Settings;
import br.com.positivo.lib.provider.PositivoDeviceProvider;
import io.flutter.embedding.android.FlutterActivity;

import static android.widget.Toast.LENGTH_LONG;
import static android.widget.Toast.LENGTH_SHORT;


import android.app.Activity;
import android.content.ActivityNotFoundException;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.util.Log;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.HashMap;
import java.util.Locale;

import rede.smartrede.sdk.Payment;
import rede.smartrede.sdk.PaymentStatus;
import rede.smartrede.sdk.Receipt;
import rede.smartrede.sdk.RedePayments;
import rede.smartrede.sdk.FlexTipoPagamento;
import rede.smartrede.sdk.RedePaymentValidationError;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {

    public static final String TAG = "Varejo+";

    public static final int REQ_CODE_PAYMENT = 1;

    public static final int REQ_CODE_REPRINT = 2;

    public static final int REQ_CODE_REVERSAL = 3;

    private static final String MONEY_PATTERN = "###,###,##0.00";

    private RedePayments redePayments;

    FlexTipoPagamento flexTipoPagamento;

    PositivoDeviceProvider positivoDeviceProvider = new PositivoDeviceProvider();
    Cipurse cipurse;
    Installer installer;
    Mifare mifare;
    Network mNetwork;
    Settings mSettings;

    public void initialize(Context context) {
        if (context != null) {
            mifare = positivoDeviceProvider.getMifare(context);
            installer = positivoDeviceProvider.getInstaller(context);
            cipurse =  positivoDeviceProvider.getCipurse(context);
            if (cipurse != null) {
                mNetwork = positivoDeviceProvider.getNetwork(context);
                mSettings = positivoDeviceProvider.getSettings(context);
                if (mNetwork != null) {
//                    String[] imeiNumbers = mNetwork.getIMEINumber();
//                    if (imeiNumbers != null && imeiNumbers.length > 0) {
//                        String[] imei = imeiNumbers; // IMEI
//                    }
                }
                if (mSettings != null) {
                   // String serialNumber = mSettings.serialNumberDevice(); // Número de série
                }
            }
        }
    }



    private static final DecimalFormat moneyFormat = new DecimalFormat(MONEY_PATTERN,
            DecimalFormatSymbols.getInstance(new Locale("pt", "BR")));

    private final String CHANNEL = "unique.identifier.method/hello";
    private final String CHANNEL1 = "unique.identifier.method/getLongAmount";
    private final String CREDITO_PARCELADO = "unique.identifier.method/creditoParcelado";
    private final String REPRINT = "unique.identifier.method/reprint";
    private final String VISTA = "unique.identifier.method/creditoVista";
    private final String CARTAO_DEBITO = "unique.identifier.method/debito";
    private final String VOUCHER = "unique.identifier.method/voucher";
    private final String REVERSAL = "unique.identifier.method/estorno";
    private final String PIX = "unique.identifier.method/pix";

    private PaymentStatusCallback paymentStatusCallback;

    private TextView PVNumberText;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel reprint = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), REPRINT);
        reprint.setMethodCallHandler((call, result) -> {

            if(call.method.equals("reprint")){
//                initialize();
                result.success(reprint());
            }else{
                result.notImplemented();
            }

        });

        MethodChannel CreditoParcelado = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CREDITO_PARCELADO);
        CreditoParcelado.setMethodCallHandler((call, result) -> {

            if(call.method.equals("creditoParcelado")){
                HashMap args = (HashMap) call.arguments;
                double valor = (double) args.get("valor");
                int parcelas = (int) args.get("parcelas");
                paymentStatusCallback = paymentStatus -> {
                    result.success(paymentStatus);
                };
                  creditoParcelado(valor,parcelas);
            }else{
                result.notImplemented();
            }
        });

        MethodChannel creditoVista = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), VISTA);
        creditoVista.setMethodCallHandler((call, result) -> {

            if(call.method.equals("creditoVista")){
                double valor = call.argument("valor");
                paymentStatusCallback = result::success;
                creditoVista(valor);
            }else{
                result.notImplemented();
            }
        });

        MethodChannel debito = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CARTAO_DEBITO);
        debito.setMethodCallHandler((call, result) -> {

            if(call.method.equals("debito")){
                double valor = call.argument("valor");
                paymentStatusCallback = new PaymentStatusCallback() {
                    @Override
                    public void onPaymentStatusReceived(String paymentStatus) {
                        result.success(paymentStatus);
                    }
                };
                debito(valor);
            }else{
                result.notImplemented();
            }
        });

        MethodChannel voucher = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), VOUCHER);
        voucher.setMethodCallHandler((call, result) -> {

            if(call.method.equals("voucher")){
                result.success(voucher());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel estorno = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), REVERSAL);
        estorno.setMethodCallHandler((call, result) -> {

            if(call.method.equals("estorno")){
                result.success(estorno());
            }else{
                result.notImplemented();
            }
        });

        MethodChannel pix = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), PIX);
        pix.setMethodCallHandler((call, result) -> {

            if(call.method.equals("pix")){
                double valor = call.argument("valor");
                paymentStatusCallback = paymentStatus -> {
                    result.success(paymentStatus);
                };
                pix(valor);
            }else{
                result.notImplemented();
            }
        });

    }

    public String reprint(){
        onReprint();
        return "printa";
    }


    public String creditoParcelado(double valor, int parcelas){
        openPaymentCreditoParcelado(valor,parcelas);
        return "ok";

    }

    public String creditoVista(double valor){
        openPaymentFragmentCreditoVista(valor);
        return "ok";
    }

    public String debito(double valor){
        openPaymentDebit(valor);
        return "ok";
    }

    public String voucher(){
        openPaymentVoucher();
        return "ok!";
    }

    public String estorno(){
        onReversal();
        return "ok!";
    }

    public String pix(double valor){
       openPaymentPix(valor);
        return "ok!";
    }



//    private BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {
//
//        @Override
//        public void onReceive(Context context, Intent intent) {
//            Bundle args = intent.getExtras();
//            String s = args.getString("PVNumber");
//            if (PVNumberText != null) {
//                PVNumberText.setText(s);
//            }
//        }
//    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        redePayments = RedePayments.getInstance(this);

        Log.d(TAG, "Resultado: " + FlexTipoPagamento.CREDITO_A_VISTA);
//        initialize(this);
//        setTitle(getString(R.string.app_name) + " v" + BuildConfig.VERSION_NAME);
    }

    //crédito parcelado sem juros

    public void openPaymentCreditoParcelado(double valor, int parcelas) {
        try {
            Intent collectPaymentIntent = redePayments
                    .intentForPaymentBuilder(FlexTipoPagamento.CREDITO_PARCELADO,
                            getLongAmount(valor))
                    .setInstallments(parcelas)// numero de parcelas
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+ ", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError) {
            Toast.makeText(this, redePaymentValidationError.getMessage(),
                    LENGTH_LONG).show();
        }
    }

    //crédito parcelado com juros
//    public void openPaymentFragmentCreditoEmissor() {
//        hideReceipt();
//        try {
//            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
//                            FlexTipoPagamento.CREDITO_PARCELADO_EMISSOR, getLongAmount())
//                    .setInstallments(4)
//                    .build();
//            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
//        } catch (ActivityNotFoundException ex) {
//            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
//        } catch (RedePaymentValidationError redePaymentValidationError){
//            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
//        }
//    }

    public void openPaymentFragmentCreditoVista(double valor) {
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.CREDITO_A_VISTA, getLongAmount(valor))
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentPix(double valor) {
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.PIX, getLongAmount(valor))
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentDebit(double valor) {
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.DEBITO, getLongAmount(valor))
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void openPaymentVoucher() {
        try {
            Intent collectPaymentIntent = redePayments.intentForPaymentBuilder(
                            FlexTipoPagamento.VOUCHER, 6)
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    private long getLongAmount(double valor) { //receber valor da compra
        BigDecimal valorBigDecimal = new BigDecimal(valor);
        BigDecimal valorArredondado = valorBigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP);
        long amount = valorArredondado.multiply(BigDecimal.valueOf(100)).longValue();
        return amount;
    }

//    private void hideReceipt(){ // ocultar receita(NF)
//       // RelativeLayout rl = findViewById(R.id.rlReceipt);
//        //rl.setVisibility(View.GONE);
//    }

//    @Override
//    public void onResume(){
//        super.onResume();
//        registerReceiver(mBroadcastReceiver, new IntentFilter("br.com.mobilerede.GetPVNumber"));
//    }
//
//    @Override
//    public void onPause(){
//        super.onPause();
//        unregisterReceiver(mBroadcastReceiver);
//    }

    public void onReprint() {
        //hideReceipt();
        try {
            Intent reprint = redePayments.intentForReprint();
            startActivityForResult(reprint, REQ_CODE_REPRINT);
        } catch(ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError){
            Toast.makeText(this, redePaymentValidationError.getMessage(), LENGTH_LONG).show();
        }
    }

    public void onReversal() {
        //hideReceipt();
        try {
            Intent reversal = redePayments.intentForReversal();
            startActivityForResult(reversal, REQ_CODE_REVERSAL);
        } catch(ActivityNotFoundException ex) {
            Log.e("Varejo+", "Poynt Payment Activity not found - did you install PoyntServices?");
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        //hideReceipt();
        String s = "";
        switch(requestCode){
            case REQ_CODE_PAYMENT:
                if(resultCode== Activity.RESULT_OK){
                    Payment payment = RedePayments.getPaymentFromIntent(data);
                    if (payment.getStatus() == PaymentStatus.AUTHORIZED) {

                        String paymentStatus = "ok!";
                        if (paymentStatusCallback != null) {
                            paymentStatusCallback.onPaymentStatusReceived(paymentStatus);
                        }

                        Receipt receipt = payment.getReceipt();
                        s = "Payment Authorized\n";
                        s += "Valor: $" + moneyFormat.format(payment.getAmount() / 100d);
                        Toast.makeText(this, s, LENGTH_LONG).show();

                    } else {
                        String paymentStatus = "erro";
                        if (paymentStatusCallback != null) {
                            paymentStatusCallback.onPaymentStatusReceived(paymentStatus);
                        }
                        String msg = "Resultado da transação:\n" + getPaymentStatus(data);
                        Toast.makeText(this, msg, LENGTH_LONG).show();
                    }
                } else if (resultCode==Activity.RESULT_CANCELED) {
                    String paymentStatus = "erro";
                    if (paymentStatusCallback != null) {
                        paymentStatusCallback.onPaymentStatusReceived(paymentStatus);
                    }
                    Toast.makeText(this, "Payment Canceled", LENGTH_SHORT).show();

                }
                break;

            case(REQ_CODE_REPRINT):
                if(resultCode==Activity.RESULT_OK) {
                    Toast.makeText(this, "Reimpressão OK", LENGTH_LONG).show();
                } else {
                    Toast.makeText(this, "Reimpressão cancelada", LENGTH_SHORT).show();
                }
                break;

            case(REQ_CODE_REVERSAL):
                if(resultCode==Activity.RESULT_OK) {
                    s = "Estorno de pagamento\n" + getPaymentStatus(data);
                    Toast.makeText(this, s, LENGTH_LONG).show();
                } else {
                    Toast.makeText(this, "Estorno cancelado", LENGTH_SHORT).show();
                }
                break;
        }
    }




    private @NonNull String getPaymentStatus(@Nullable Intent intent) {
        String result = "Sem objeto Payment";
        if (intent != null) {
            Payment payment = RedePayments.getPaymentFromIntent(intent);
            if (payment != null) {
                PaymentStatus status = payment.getStatus();
                if (status != null) {
                    result = status.toString();
                } else {
                    result = "Sem status no Payment";
                }
            }
        }
        return result;
    }

//    private String showReceipt(Receipt receipt){
//
//        String result ="";
//        result += "CNPJ: "+ receipt.getCNPJ() +
//                " ///nome da loja: "+ receipt.getStoreName() +
//                " ///dono do cartao: "+ receipt.getCardHolderName();
//
//        return result;
//    }
public interface PaymentStatusCallback {
    void onPaymentStatusReceived(String paymentStatus);
}

}

