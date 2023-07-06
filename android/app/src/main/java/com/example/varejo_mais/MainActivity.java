package com.example.varejo_mais;

import io.flutter.embedding.android.FlutterActivity;

import static android.widget.Toast.LENGTH_LONG;


import android.content.ActivityNotFoundException;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.EditText;
import android.text.TextUtils;

import rede.smartrede.sdk.RedePayments;
import rede.smartrede.sdk.FlexTipoPagamento;
import rede.smartrede.sdk.Payment;
import rede.smartrede.sdk.PaymentStatus;
import rede.smartrede.sdk.Receipt;
import rede.smartrede.sdk.RedePaymentValidationError;

import android.os.Handler;
import android.os.Looper;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.EventChannel;
import java.text.SimpleDateFormat;
import java.util.*;

import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends FlutterActivity {

    public static final String TAG = "Varejo+";

    public static final int REQ_CODE_PAYMENT = 1;

    private RedePayments redePayments;

    private final String CHANNEL = "unique.identifier.method/hello";
    private final String CHANNEL1 = "unique.identifier.method/getLongAmount";

    private TextView PVNumberText;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        methodChannel.setMethodCallHandler((call, result) -> {
            if (call.method.equals("getHelloWorld")) {
                String user = call.argument("user");
                if (user == null) {
                    result.success("Hello World");
                } else {
                    result.success("Hello World, " + user);
                    MethodChannel callbackChannel = new MethodChannel(
                            flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
                    callbackChannel.invokeMethod("methodCallback", "result callback kt");
                }
            } else {
                result.notImplemented();
            }
        });

        MethodChannel methodChannel2 = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL1);
        methodChannel2.setMethodCallHandler((call, result) -> {
            if (call.method.equals("getLongAmount")) {
                result.success(getLongAmount());
            }
        });
    }

    private BroadcastReceiver mBroadcastReceiver = new BroadcastReceiver() {
        @Override
        public void onReceive(Context context, Intent intent) {
            Bundle args = intent.getExtras();
            String s = args.getString("PVNumber");
            if (PVNumberText != null) {
                PVNumberText.setText(s);
            }
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        redePayments = RedePayments.getInstance(this);

        //setContentView(R.layout.);
        setTitle(getString(R.string.app_name) + " v" + BuildConfig.VERSION_NAME);

        PVNumberText = findViewById(R.id.PVNumberText);
    }

    public void openPaymentFragment() {
        // hideReceipt();
        try {
            Intent collectPaymentIntent = redePayments
                    .intentForPaymentBuilder(FlexTipoPagamento.CREDITO_PARCELADO,
                            getLongAmount())
                    .setInstallments(4)
                    .build();
            startActivityForResult(collectPaymentIntent, REQ_CODE_PAYMENT);
        } catch (ActivityNotFoundException ex) {
            Log.e("Varejo+ ", "Poynt Payment Activity not found - did you install PoyntServices?");
        } catch (RedePaymentValidationError redePaymentValidationError) {
            Toast.makeText(this, redePaymentValidationError.getMessage(),
                    LENGTH_LONG).show();
        }
    }

    private int getLongAmount() {
        //TODO
        int amount = 100;
        // String amountString = ((EditText)
        // findViewById(R.id.valor)).getText().toString();
        // if (!TextUtils.isEmpty(amountString)) {
        // amount = Integer.parseInt(amountString);
        // }
        return amount;
    }

}
