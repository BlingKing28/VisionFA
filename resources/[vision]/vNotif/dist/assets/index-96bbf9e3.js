(function() {
    const n = document.createElement("link").relList;
    if (n && n.supports && n.supports("modulepreload")) return;
    for (const l of document.querySelectorAll('link[rel="modulepreload"]')) r(l);
    new MutationObserver(l => {
        for (const i of l)
            if (i.type === "childList")
                for (const o of i.addedNodes) o.tagName === "LINK" && o.rel === "modulepreload" && r(o)
    }).observe(document, {
        childList: !0,
        subtree: !0
    });

    function t(l) {
        const i = {};
        return l.integrity && (i.integrity = l.integrity), l.referrerPolicy && (i.referrerPolicy = l.referrerPolicy), l.crossOrigin === "use-credentials" ? i.credentials = "include" : l.crossOrigin === "anonymous" ? i.credentials = "omit" : i.credentials = "same-origin", i
    }

    function r(l) {
        if (l.ep) return;
        l.ep = !0;
        const i = t(l);
        fetch(l.href, i)
    }
})();

function yf(e) {
    return e && e.__esModule && Object.prototype.hasOwnProperty.call(e, "default") ? e.default : e
}
var Qa = {
        exports: {}
    },
    Nl = {},
    Ka = {
        exports: {}
    },
    O = {};

var fr = Symbol.for("react.element"),
    xf = Symbol.for("react.portal"),
    wf = Symbol.for("react.fragment"),
    Cf = Symbol.for("react.strict_mode"),
    kf = Symbol.for("react.profiler"),
    Sf = Symbol.for("react.provider"),
    Ef = Symbol.for("react.context"),
    _f = Symbol.for("react.forward_ref"),
    Nf = Symbol.for("react.suspense"),
    jf = Symbol.for("react.memo"),
    Lf = Symbol.for("react.lazy"),
    Cu = Symbol.iterator;

function Tf(e) {
    return e === null || typeof e != "object" ? null : (e = Cu && e[Cu] || e["@@iterator"], typeof e == "function" ? e : null)
}
var Ga = {
        isMounted: function() {
            return !1
        },
        enqueueForceUpdate: function() {},
        enqueueReplaceState: function() {},
        enqueueSetState: function() {}
    },
    Za = Object.assign,
    Xa = {};

function wt(e, n, t) {
    this.props = e, this.context = n, this.refs = Xa, this.updater = t || Ga
}
wt.prototype.isReactComponent = {};
wt.prototype.setState = function(e, n) {
    if (typeof e != "object" && typeof e != "function" && e != null) throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
    this.updater.enqueueSetState(this, e, n, "setState")
};
wt.prototype.forceUpdate = function(e) {
    this.updater.enqueueForceUpdate(this, e, "forceUpdate")
};

function Ya() {}
Ya.prototype = wt.prototype;

function ko(e, n, t) {
    this.props = e, this.context = n, this.refs = Xa, this.updater = t || Ga
}
var So = ko.prototype = new Ya;
So.constructor = ko;
Za(So, wt.prototype);
So.isPureReactComponent = !0;
var ku = Array.isArray,
    Ja = Object.prototype.hasOwnProperty,
    Eo = {
        current: null
    },
    qa = {
        key: !0,
        ref: !0,
        __self: !0,
        __source: !0
    };

function ba(e, n, t) {
    var r, l = {},
        i = null,
        o = null;
    if (n != null)
        for (r in n.ref !== void 0 && (o = n.ref), n.key !== void 0 && (i = "" + n.key), n) Ja.call(n, r) && !qa.hasOwnProperty(r) && (l[r] = n[r]);
    var u = arguments.length - 2;
    if (u === 1) l.children = t;
    else if (1 < u) {
        for (var a = Array(u), s = 0; s < u; s++) a[s] = arguments[s + 2];
        l.children = a
    }
    if (e && e.defaultProps)
        for (r in u = e.defaultProps, u) l[r] === void 0 && (l[r] = u[r]);
    return {
        $$typeof: fr,
        type: e,
        key: i,
        ref: o,
        props: l,
        _owner: Eo.current
    }
}

function Pf(e, n) {
    return {
        $$typeof: fr,
        type: e.type,
        key: n,
        ref: e.ref,
        props: e.props,
        _owner: e._owner
    }
}

function _o(e) {
    return typeof e == "object" && e !== null && e.$$typeof === fr
}

function Df(e) {
    var n = {
        "=": "=0",
        ":": "=2"
    };
    return "$" + e.replace(/[=:]/g, function(t) {
        return n[t]
    })
}
var Su = /\/+/g;

function Kl(e, n) {
    return typeof e == "object" && e !== null && e.key != null ? Df("" + e.key) : n.toString(36)
}

function Vr(e, n, t, r, l) {
    var i = typeof e;
    (i === "undefined" || i === "boolean") && (e = null);
    var o = !1;
    if (e === null) o = !0;
    else switch (i) {
        case "string":
        case "number":
            o = !0;
            break;
        case "object":
            switch (e.$$typeof) {
                case fr:
                case xf:
                    o = !0
            }
    }
    if (o) return o = e, l = l(o), e = r === "" ? "." + Kl(o, 0) : r, ku(l) ? (t = "", e != null && (t = e.replace(Su, "$&/") + "/"), Vr(l, n, t, "", function(s) {
        return s
    })) : l != null && (_o(l) && (l = Pf(l, t + (!l.key || o && o.key === l.key ? "" : ("" + l.key).replace(Su, "$&/") + "/") + e)), n.push(l)), 1;
    if (o = 0, r = r === "" ? "." : r + ":", ku(e))
        for (var u = 0; u < e.length; u++) {
            i = e[u];
            var a = r + Kl(i, u);
            o += Vr(i, n, t, a, l)
        } else if (a = Tf(e), typeof a == "function")
        for (e = a.call(e), u = 0; !(i = e.next()).done;) i = i.value, a = r + Kl(i, u++), o += Vr(i, n, t, a, l);
    else if (i === "object") throw n = String(e), Error("Objects are not valid as a React child (found: " + (n === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : n) + "). If you meant to render a collection of children, use an array instead.");
    return o
}

function wr(e, n, t) {
    if (e == null) return e;
    var r = [],
        l = 0;
    return Vr(e, r, "", "", function(i) {
        return n.call(t, i, l++)
    }), r
}

function zf(e) {
    if (e._status === -1) {
        var n = e._result;
        n = n(), n.then(function(t) {
            (e._status === 0 || e._status === -1) && (e._status = 1, e._result = t)
        }, function(t) {
            (e._status === 0 || e._status === -1) && (e._status = 2, e._result = t)
        }), e._status === -1 && (e._status = 0, e._result = n)
    }
    if (e._status === 1) return e._result.default;
    throw e._result
}
var fe = {
        current: null
    },
    Wr = {
        transition: null
    },
    Of = {
        ReactCurrentDispatcher: fe,
        ReactCurrentBatchConfig: Wr,
        ReactCurrentOwner: Eo
    };
O.Children = {
    map: wr,
    forEach: function(e, n, t) {
        wr(e, function() {
            n.apply(this, arguments)
        }, t)
    },
    count: function(e) {
        var n = 0;
        return wr(e, function() {
            n++
        }), n
    },
    toArray: function(e) {
        return wr(e, function(n) {
            return n
        }) || []
    },
    only: function(e) {
        if (!_o(e)) throw Error("React.Children.only expected to receive a single React element child.");
        return e
    }
};
O.Component = wt;
O.Fragment = wf;
O.Profiler = kf;
O.PureComponent = ko;
O.StrictMode = Cf;
O.Suspense = Nf;
O.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Of;
O.cloneElement = function(e, n, t) {
    if (e == null) throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
    var r = Za({}, e.props),
        l = e.key,
        i = e.ref,
        o = e._owner;
    if (n != null) {
        if (n.ref !== void 0 && (i = n.ref, o = Eo.current), n.key !== void 0 && (l = "" + n.key), e.type && e.type.defaultProps) var u = e.type.defaultProps;
        for (a in n) Ja.call(n, a) && !qa.hasOwnProperty(a) && (r[a] = n[a] === void 0 && u !== void 0 ? u[a] : n[a])
    }
    var a = arguments.length - 2;
    if (a === 1) r.children = t;
    else if (1 < a) {
        u = Array(a);
        for (var s = 0; s < a; s++) u[s] = arguments[s + 2];
        r.children = u
    }
    return {
        $$typeof: fr,
        type: e.type,
        key: l,
        ref: i,
        props: r,
        _owner: o
    }
};
O.createContext = function(e) {
    return e = {
        $$typeof: Ef,
        _currentValue: e,
        _currentValue2: e,
        _threadCount: 0,
        Provider: null,
        Consumer: null,
        _defaultValue: null,
        _globalName: null
    }, e.Provider = {
        $$typeof: Sf,
        _context: e
    }, e.Consumer = e
};
O.createElement = ba;
O.createFactory = function(e) {
    var n = ba.bind(null, e);
    return n.type = e, n
};
O.createRef = function() {
    return {
        current: null
    }
};
O.forwardRef = function(e) {
    return {
        $$typeof: _f,
        render: e
    }
};
O.isValidElement = _o;
O.lazy = function(e) {
    return {
        $$typeof: Lf,
        _payload: {
            _status: -1,
            _result: e
        },
        _init: zf
    }
};
O.memo = function(e, n) {
    return {
        $$typeof: jf,
        type: e,
        compare: n === void 0 ? null : n
    }
};
O.startTransition = function(e) {
    var n = Wr.transition;
    Wr.transition = {};
    try {
        e()
    } finally {
        Wr.transition = n
    }
};
O.unstable_act = function() {
    throw Error("act(...) is not supported in production builds of React.")
};
O.useCallback = function(e, n) {
    return fe.current.useCallback(e, n)
};
O.useContext = function(e) {
    return fe.current.useContext(e)
};
O.useDebugValue = function() {};
O.useDeferredValue = function(e) {
    return fe.current.useDeferredValue(e)
};
O.useEffect = function(e, n) {
    return fe.current.useEffect(e, n)
};
O.useId = function() {
    return fe.current.useId()
};
O.useImperativeHandle = function(e, n, t) {
    return fe.current.useImperativeHandle(e, n, t)
};
O.useInsertionEffect = function(e, n) {
    return fe.current.useInsertionEffect(e, n)
};
O.useLayoutEffect = function(e, n) {
    return fe.current.useLayoutEffect(e, n)
};
O.useMemo = function(e, n) {
    return fe.current.useMemo(e, n)
};
O.useReducer = function(e, n, t) {
    return fe.current.useReducer(e, n, t)
};
O.useRef = function(e) {
    return fe.current.useRef(e)
};
O.useState = function(e) {
    return fe.current.useState(e)
};
O.useSyncExternalStore = function(e, n, t) {
    return fe.current.useSyncExternalStore(e, n, t)
};
O.useTransition = function() {
    return fe.current.useTransition()
};
O.version = "18.2.0";
Ka.exports = O;
var T = Ka.exports;
const A = yf(T);

var Rf = T,
    If = Symbol.for("react.element"),
    Mf = Symbol.for("react.fragment"),
    Ff = Object.prototype.hasOwnProperty,
    Af = Rf.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,
    Uf = {
        key: !0,
        ref: !0,
        __self: !0,
        __source: !0
    };

function es(e, n, t) {
    var r, l = {},
        i = null,
        o = null;
    t !== void 0 && (i = "" + t), n.key !== void 0 && (i = "" + n.key), n.ref !== void 0 && (o = n.ref);
    for (r in n) Ff.call(n, r) && !Uf.hasOwnProperty(r) && (l[r] = n[r]);
    if (e && e.defaultProps)
        for (r in n = e.defaultProps, n) l[r] === void 0 && (l[r] = n[r]);
    return {
        $$typeof: If,
        type: e,
        key: i,
        ref: o,
        props: l,
        _owner: Af.current
    }
}
Nl.Fragment = Mf;
Nl.jsx = es;
Nl.jsxs = es;
Qa.exports = Nl;
var p = Qa.exports,
    Ei = {},
    ns = {
        exports: {}
    },
    ke = {},
    ts = {
        exports: {}
    },
    rs = {};

(function(e) {
    function n(j, D) {
        var z = j.length;
        j.push(D);
        e: for (; 0 < z;) {
            var G = z - 1 >>> 1,
                b = j[G];
            if (0 < l(b, D)) j[G] = D, j[z] = b, z = G;
            else break e
        }
    }

    function t(j) {
        return j.length === 0 ? null : j[0]
    }

    function r(j) {
        if (j.length === 0) return null;
        var D = j[0],
            z = j.pop();
        if (z !== D) {
            j[0] = z;
            e: for (var G = 0, b = j.length, yr = b >>> 1; G < yr;) {
                var Sn = 2 * (G + 1) - 1,
                    Ql = j[Sn],
                    En = Sn + 1,
                    xr = j[En];
                if (0 > l(Ql, z)) En < b && 0 > l(xr, Ql) ? (j[G] = xr, j[En] = z, G = En) : (j[G] = Ql, j[Sn] = z, G = Sn);
                else if (En < b && 0 > l(xr, z)) j[G] = xr, j[En] = z, G = En;
                else break e
            }
        }
        return D
    }

    function l(j, D) {
        var z = j.sortIndex - D.sortIndex;
        return z !== 0 ? z : j.id - D.id
    }
    if (typeof performance == "object" && typeof performance.now == "function") {
        var i = performance;
        e.unstable_now = function() {
            return i.now()
        }
    } else {
        var o = Date,
            u = o.now();
        e.unstable_now = function() {
            return o.now() - u
        }
    }
    var a = [],
        s = [],
        m = 1,
        v = null,
        h = 3,
        C = !1,
        g = !1,
        x = !1,
        L = typeof setTimeout == "function" ? setTimeout : null,
        f = typeof clearTimeout == "function" ? clearTimeout : null,
        c = typeof setImmediate < "u" ? setImmediate : null;
    typeof navigator < "u" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);

    function d(j) {
        for (var D = t(s); D !== null;) {
            if (D.callback === null) r(s);
            else if (D.startTime <= j) r(s), D.sortIndex = D.expirationTime, n(a, D);
            else break;
            D = t(s)
        }
    }

    function y(j) {
        if (x = !1, d(j), !g)
            if (t(a) !== null) g = !0, Vl(S);
            else {
                var D = t(s);
                D !== null && Wl(y, D.startTime - j)
            }
    }

    function S(j, D) {
        g = !1, x && (x = !1, f(_), _ = -1), C = !0;
        var z = h;
        try {
            for (d(D), v = t(a); v !== null && (!(v.expirationTime > D) || j && !q());) {
                var G = v.callback;
                if (typeof G == "function") {
                    v.callback = null, h = v.priorityLevel;
                    var b = G(v.expirationTime <= D);
                    D = e.unstable_now(), typeof b == "function" ? v.callback = b : v === t(a) && r(a), d(D)
                } else r(a);
                v = t(a)
            }
            if (v !== null) var yr = !0;
            else {
                var Sn = t(s);
                Sn !== null && Wl(y, Sn.startTime - D), yr = !1
            }
            return yr
        } finally {
            v = null, h = z, C = !1
        }
    }
    var E = !1,
        w = null,
        _ = -1,
        R = 5,
        P = -1;

    function q() {
        return !(e.unstable_now() - P < R)
    }

    function nn() {
        if (w !== null) {
            var j = e.unstable_now();
            P = j;
            var D = !0;
            try {
                D = w(!0, j)
            } finally {
                D ? Pe() : (E = !1, w = null)
            }
        } else E = !1
    }
    var Pe;
    if (typeof c == "function") Pe = function() {
        c(nn)
    };
    else if (typeof MessageChannel < "u") {
        var wu = new MessageChannel,
            gf = wu.port2;
        wu.port1.onmessage = nn, Pe = function() {
            gf.postMessage(null)
        }
    } else Pe = function() {
        L(nn, 0)
    };

    function Vl(j) {
        w = j, E || (E = !0, Pe())
    }

    function Wl(j, D) {
        _ = L(function() {
            j(e.unstable_now())
        }, D)
    }
    e.unstable_IdlePriority = 5, e.unstable_ImmediatePriority = 1, e.unstable_LowPriority = 4, e.unstable_NormalPriority = 3, e.unstable_Profiling = null, e.unstable_UserBlockingPriority = 2, e.unstable_cancelCallback = function(j) {
        j.callback = null
    }, e.unstable_continueExecution = function() {
        g || C || (g = !0, Vl(S))
    }, e.unstable_forceFrameRate = function(j) {
        0 > j || 125 < j ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : R = 0 < j ? Math.floor(1e3 / j) : 5
    }, e.unstable_getCurrentPriorityLevel = function() {
        return h
    }, e.unstable_getFirstCallbackNode = function() {
        return t(a)
    }, e.unstable_next = function(j) {
        switch (h) {
            case 1:
            case 2:
            case 3:
                var D = 3;
                break;
            default:
                D = h
        }
        var z = h;
        h = D;
        try {
            return j()
        } finally {
            h = z
        }
    }, e.unstable_pauseExecution = function() {}, e.unstable_requestPaint = function() {}, e.unstable_runWithPriority = function(j, D) {
        switch (j) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                break;
            default:
                j = 3
        }
        var z = h;
        h = j;
        try {
            return D()
        } finally {
            h = z
        }
    }, e.unstable_scheduleCallback = function(j, D, z) {
        var G = e.unstable_now();
        switch (typeof z == "object" && z !== null ? (z = z.delay, z = typeof z == "number" && 0 < z ? G + z : G) : z = G, j) {
            case 1:
                var b = -1;
                break;
            case 2:
                b = 250;
                break;
            case 5:
                b = 1073741823;
                break;
            case 4:
                b = 1e4;
                break;
            default:
                b = 5e3
        }
        return b = z + b, j = {
            id: m++,
            callback: D,
            priorityLevel: j,
            startTime: z,
            expirationTime: b,
            sortIndex: -1
        }, z > G ? (j.sortIndex = z, n(s, j), t(a) === null && j === t(s) && (x ? (f(_), _ = -1) : x = !0, Wl(y, z - G))) : (j.sortIndex = b, n(a, j), g || C || (g = !0, Vl(S))), j
    }, e.unstable_shouldYield = q, e.unstable_wrapCallback = function(j) {
        var D = h;
        return function() {
            var z = h;
            h = D;
            try {
                return j.apply(this, arguments)
            } finally {
                h = z
            }
        }
    }
})(rs);
ts.exports = rs;
var $f = ts.exports;

var ls = T,
    Ce = $f;

function k(e) {
    for (var n = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, t = 1; t < arguments.length; t++) n += "&args[]=" + encodeURIComponent(arguments[t]);
    return "Minified React error #" + e + "; visit " + n + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var is = new Set,
    Zt = {};

function $n(e, n) {
    dt(e, n), dt(e + "Capture", n)
}

function dt(e, n) {
    for (Zt[e] = n, e = 0; e < n.length; e++) is.add(n[e])
}
var Ye = !(typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u"),
    _i = Object.prototype.hasOwnProperty,
    Bf = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,
    Eu = {},
    _u = {};

function Hf(e) {
    return _i.call(_u, e) ? !0 : _i.call(Eu, e) ? !1 : Bf.test(e) ? _u[e] = !0 : (Eu[e] = !0, !1)
}

function Vf(e, n, t, r) {
    if (t !== null && t.type === 0) return !1;
    switch (typeof n) {
        case "function":
        case "symbol":
            return !0;
        case "boolean":
            return r ? !1 : t !== null ? !t.acceptsBooleans : (e = e.toLowerCase().slice(0, 5), e !== "data-" && e !== "aria-");
        default:
            return !1
    }
}

function Wf(e, n, t, r) {
    if (n === null || typeof n > "u" || Vf(e, n, t, r)) return !0;
    if (r) return !1;
    if (t !== null) switch (t.type) {
        case 3:
            return !n;
        case 4:
            return n === !1;
        case 5:
            return isNaN(n);
        case 6:
            return isNaN(n) || 1 > n
    }
    return !1
}

function de(e, n, t, r, l, i, o) {
    this.acceptsBooleans = n === 2 || n === 3 || n === 4, this.attributeName = r, this.attributeNamespace = l, this.mustUseProperty = t, this.propertyName = e, this.type = n, this.sanitizeURL = i, this.removeEmptyString = o
}
var le = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e) {
    le[e] = new de(e, 0, !1, e, null, !1, !1)
});
[
    ["acceptCharset", "accept-charset"],
    ["className", "class"],
    ["htmlFor", "for"],
    ["httpEquiv", "http-equiv"]
].forEach(function(e) {
    var n = e[0];
    le[n] = new de(n, 1, !1, e[1], null, !1, !1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function(e) {
    le[e] = new de(e, 2, !1, e.toLowerCase(), null, !1, !1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function(e) {
    le[e] = new de(e, 2, !1, e, null, !1, !1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e) {
    le[e] = new de(e, 3, !1, e.toLowerCase(), null, !1, !1)
});
["checked", "multiple", "muted", "selected"].forEach(function(e) {
    le[e] = new de(e, 3, !0, e, null, !1, !1)
});
["capture", "download"].forEach(function(e) {
    le[e] = new de(e, 4, !1, e, null, !1, !1)
});
["cols", "rows", "size", "span"].forEach(function(e) {
    le[e] = new de(e, 6, !1, e, null, !1, !1)
});
["rowSpan", "start"].forEach(function(e) {
    le[e] = new de(e, 5, !1, e.toLowerCase(), null, !1, !1)
});
var No = /[\-:]([a-z])/g;

function jo(e) {
    return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e) {
    var n = e.replace(No, jo);
    le[n] = new de(n, 1, !1, e, null, !1, !1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e) {
    var n = e.replace(No, jo);
    le[n] = new de(n, 1, !1, e, "http://www.w3.org/1999/xlink", !1, !1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function(e) {
    var n = e.replace(No, jo);
    le[n] = new de(n, 1, !1, e, "http://www.w3.org/XML/1998/namespace", !1, !1)
});
["tabIndex", "crossOrigin"].forEach(function(e) {
    le[e] = new de(e, 1, !1, e.toLowerCase(), null, !1, !1)
});
le.xlinkHref = new de("xlinkHref", 1, !1, "xlink:href", "http://www.w3.org/1999/xlink", !0, !1);
["src", "href", "action", "formAction"].forEach(function(e) {
    le[e] = new de(e, 1, !1, e.toLowerCase(), null, !0, !0)
});

function Lo(e, n, t, r) {
    var l = le.hasOwnProperty(n) ? le[n] : null;
    (l !== null ? l.type !== 0 : r || !(2 < n.length) || n[0] !== "o" && n[0] !== "O" || n[1] !== "n" && n[1] !== "N") && (Wf(n, t, l, r) && (t = null), r || l === null ? Hf(n) && (t === null ? e.removeAttribute(n) : e.setAttribute(n, "" + t)) : l.mustUseProperty ? e[l.propertyName] = t === null ? l.type === 3 ? !1 : "" : t : (n = l.attributeName, r = l.attributeNamespace, t === null ? e.removeAttribute(n) : (l = l.type, t = l === 3 || l === 4 && t === !0 ? "" : "" + t, r ? e.setAttributeNS(r, n, t) : e.setAttribute(n, t))))
}
var en = ls.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,
    Cr = Symbol.for("react.element"),
    Gn = Symbol.for("react.portal"),
    Zn = Symbol.for("react.fragment"),
    To = Symbol.for("react.strict_mode"),
    Ni = Symbol.for("react.profiler"),
    os = Symbol.for("react.provider"),
    us = Symbol.for("react.context"),
    Po = Symbol.for("react.forward_ref"),
    ji = Symbol.for("react.suspense"),
    Li = Symbol.for("react.suspense_list"),
    Do = Symbol.for("react.memo"),
    rn = Symbol.for("react.lazy"),
    as = Symbol.for("react.offscreen"),
    Nu = Symbol.iterator;

function St(e) {
    return e === null || typeof e != "object" ? null : (e = Nu && e[Nu] || e["@@iterator"], typeof e == "function" ? e : null)
}
var Q = Object.assign,
    Gl;

function Rt(e) {
    if (Gl === void 0) try {
        throw Error()
    } catch (t) {
        var n = t.stack.trim().match(/\n( *(at )?)/);
        Gl = n && n[1] || ""
    }
    return `
` + Gl + e
}
var Zl = !1;

function Xl(e, n) {
    if (!e || Zl) return "";
    Zl = !0;
    var t = Error.prepareStackTrace;
    Error.prepareStackTrace = void 0;
    try {
        if (n)
            if (n = function() {
                throw Error()
            }, Object.defineProperty(n.prototype, "props", {
                set: function() {
                    throw Error()
                }
            }), typeof Reflect == "object" && Reflect.construct) {
                try {
                    Reflect.construct(n, [])
                } catch (s) {
                    var r = s
                }
                Reflect.construct(e, [], n)
            } else {
                try {
                    n.call()
                } catch (s) {
                    r = s
                }
                e.call(n.prototype)
            }
        else {
            try {
                throw Error()
            } catch (s) {
                r = s
            }
            e()
        }
    } catch (s) {
        if (s && r && typeof s.stack == "string") {
            for (var l = s.stack.split(`
`), i = r.stack.split(`
`), o = l.length - 1, u = i.length - 1; 1 <= o && 0 <= u && l[o] !== i[u];) u--;
            for (; 1 <= o && 0 <= u; o--, u--)
                if (l[o] !== i[u]) {
                    if (o !== 1 || u !== 1)
                        do
                            if (o--, u--, 0 > u || l[o] !== i[u]) {
                                var a = `
` + l[o].replace(" at new ", " at ");
                                return e.displayName && a.includes("<anonymous>") && (a = a.replace("<anonymous>", e.displayName)), a
                            } while (1 <= o && 0 <= u);
                    break
                }
        }
    } finally {
        Zl = !1, Error.prepareStackTrace = t
    }
    return (e = e ? e.displayName || e.name : "") ? Rt(e) : ""
}

function Qf(e) {
    switch (e.tag) {
        case 5:
            return Rt(e.type);
        case 16:
            return Rt("Lazy");
        case 13:
            return Rt("Suspense");
        case 19:
            return Rt("SuspenseList");
        case 0:
        case 2:
        case 15:
            return e = Xl(e.type, !1), e;
        case 11:
            return e = Xl(e.type.render, !1), e;
        case 1:
            return e = Xl(e.type, !0), e;
        default:
            return ""
    }
}

function Ti(e) {
    if (e == null) return null;
    if (typeof e == "function") return e.displayName || e.name || null;
    if (typeof e == "string") return e;
    switch (e) {
        case Zn:
            return "Fragment";
        case Gn:
            return "Portal";
        case Ni:
            return "Profiler";
        case To:
            return "StrictMode";
        case ji:
            return "Suspense";
        case Li:
            return "SuspenseList"
    }
    if (typeof e == "object") switch (e.$$typeof) {
        case us:
            return (e.displayName || "Context") + ".Consumer";
        case os:
            return (e._context.displayName || "Context") + ".Provider";
        case Po:
            var n = e.render;
            return e = e.displayName, e || (e = n.displayName || n.name || "", e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"), e;
        case Do:
            return n = e.displayName || null, n !== null ? n : Ti(e.type) || "Memo";
        case rn:
            n = e._payload, e = e._init;
            try {
                return Ti(e(n))
            } catch {}
    }
    return null
}

function Kf(e) {
    var n = e.type;
    switch (e.tag) {
        case 24:
            return "Cache";
        case 9:
            return (n.displayName || "Context") + ".Consumer";
        case 10:
            return (n._context.displayName || "Context") + ".Provider";
        case 18:
            return "DehydratedFragment";
        case 11:
            return e = n.render, e = e.displayName || e.name || "", n.displayName || (e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef");
        case 7:
            return "Fragment";
        case 5:
            return n;
        case 4:
            return "Portal";
        case 3:
            return "Root";
        case 6:
            return "Text";
        case 16:
            return Ti(n);
        case 8:
            return n === To ? "StrictMode" : "Mode";
        case 22:
            return "Offscreen";
        case 12:
            return "Profiler";
        case 21:
            return "Scope";
        case 13:
            return "Suspense";
        case 19:
            return "SuspenseList";
        case 25:
            return "TracingMarker";
        case 1:
        case 0:
        case 17:
        case 2:
        case 14:
        case 15:
            if (typeof n == "function") return n.displayName || n.name || null;
            if (typeof n == "string") return n
    }
    return null
}

function yn(e) {
    switch (typeof e) {
        case "boolean":
        case "number":
        case "string":
        case "undefined":
            return e;
        case "object":
            return e;
        default:
            return ""
    }
}

function ss(e) {
    var n = e.type;
    return (e = e.nodeName) && e.toLowerCase() === "input" && (n === "checkbox" || n === "radio")
}

function Gf(e) {
    var n = ss(e) ? "checked" : "value",
        t = Object.getOwnPropertyDescriptor(e.constructor.prototype, n),
        r = "" + e[n];
    if (!e.hasOwnProperty(n) && typeof t < "u" && typeof t.get == "function" && typeof t.set == "function") {
        var l = t.get,
            i = t.set;
        return Object.defineProperty(e, n, {
            configurable: !0,
            get: function() {
                return l.call(this)
            },
            set: function(o) {
                r = "" + o, i.call(this, o)
            }
        }), Object.defineProperty(e, n, {
            enumerable: t.enumerable
        }), {
            getValue: function() {
                return r
            },
            setValue: function(o) {
                r = "" + o
            },
            stopTracking: function() {
                e._valueTracker = null, delete e[n]
            }
        }
    }
}

function kr(e) {
    e._valueTracker || (e._valueTracker = Gf(e))
}

function cs(e) {
    if (!e) return !1;
    var n = e._valueTracker;
    if (!n) return !0;
    var t = n.getValue(),
        r = "";
    return e && (r = ss(e) ? e.checked ? "true" : "false" : e.value), e = r, e !== t ? (n.setValue(e), !0) : !1
}

function nl(e) {
    if (e = e || (typeof document < "u" ? document : void 0), typeof e > "u") return null;
    try {
        return e.activeElement || e.body
    } catch {
        return e.body
    }
}

function Pi(e, n) {
    var t = n.checked;
    return Q({}, n, {
        defaultChecked: void 0,
        defaultValue: void 0,
        value: void 0,
        checked: t ?? e._wrapperState.initialChecked
    })
}

function ju(e, n) {
    var t = n.defaultValue == null ? "" : n.defaultValue,
        r = n.checked != null ? n.checked : n.defaultChecked;
    t = yn(n.value != null ? n.value : t), e._wrapperState = {
        initialChecked: r,
        initialValue: t,
        controlled: n.type === "checkbox" || n.type === "radio" ? n.checked != null : n.value != null
    }
}

function fs(e, n) {
    n = n.checked, n != null && Lo(e, "checked", n, !1)
}

function Di(e, n) {
    fs(e, n);
    var t = yn(n.value),
        r = n.type;
    if (t != null) r === "number" ? (t === 0 && e.value === "" || e.value != t) && (e.value = "" + t) : e.value !== "" + t && (e.value = "" + t);
    else if (r === "submit" || r === "reset") {
        e.removeAttribute("value");
        return
    }
    n.hasOwnProperty("value") ? zi(e, n.type, t) : n.hasOwnProperty("defaultValue") && zi(e, n.type, yn(n.defaultValue)), n.checked == null && n.defaultChecked != null && (e.defaultChecked = !!n.defaultChecked)
}

function Lu(e, n, t) {
    if (n.hasOwnProperty("value") || n.hasOwnProperty("defaultValue")) {
        var r = n.type;
        if (!(r !== "submit" && r !== "reset" || n.value !== void 0 && n.value !== null)) return;
        n = "" + e._wrapperState.initialValue, t || n === e.value || (e.value = n), e.defaultValue = n
    }
    t = e.name, t !== "" && (e.name = ""), e.defaultChecked = !!e._wrapperState.initialChecked, t !== "" && (e.name = t)
}

function zi(e, n, t) {
    (n !== "number" || nl(e.ownerDocument) !== e) && (t == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + t && (e.defaultValue = "" + t))
}
var It = Array.isArray;

function ot(e, n, t, r) {
    if (e = e.options, n) {
        n = {};
        for (var l = 0; l < t.length; l++) n["$" + t[l]] = !0;
        for (t = 0; t < e.length; t++) l = n.hasOwnProperty("$" + e[t].value), e[t].selected !== l && (e[t].selected = l), l && r && (e[t].defaultSelected = !0)
    } else {
        for (t = "" + yn(t), n = null, l = 0; l < e.length; l++) {
            if (e[l].value === t) {
                e[l].selected = !0, r && (e[l].defaultSelected = !0);
                return
            }
            n !== null || e[l].disabled || (n = e[l])
        }
        n !== null && (n.selected = !0)
    }
}

function Oi(e, n) {
    if (n.dangerouslySetInnerHTML != null) throw Error(k(91));
    return Q({}, n, {
        value: void 0,
        defaultValue: void 0,
        children: "" + e._wrapperState.initialValue
    })
}

function Tu(e, n) {
    var t = n.value;
    if (t == null) {
        if (t = n.children, n = n.defaultValue, t != null) {
            if (n != null) throw Error(k(92));
            if (It(t)) {
                if (1 < t.length) throw Error(k(93));
                t = t[0]
            }
            n = t
        }
        n == null && (n = ""), t = n
    }
    e._wrapperState = {
        initialValue: yn(t)
    }
}

function ds(e, n) {
    var t = yn(n.value),
        r = yn(n.defaultValue);
    t != null && (t = "" + t, t !== e.value && (e.value = t), n.defaultValue == null && e.defaultValue !== t && (e.defaultValue = t)), r != null && (e.defaultValue = "" + r)
}

function Pu(e) {
    var n = e.textContent;
    n === e._wrapperState.initialValue && n !== "" && n !== null && (e.value = n)
}

function ps(e) {
    switch (e) {
        case "svg":
            return "http://www.w3.org/2000/svg";
        case "math":
            return "http://www.w3.org/1998/Math/MathML";
        default:
            return "http://www.w3.org/1999/xhtml"
    }
}

function Ri(e, n) {
    return e == null || e === "http://www.w3.org/1999/xhtml" ? ps(n) : e === "http://www.w3.org/2000/svg" && n === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var Sr, ms = function(e) {
    return typeof MSApp < "u" && MSApp.execUnsafeLocalFunction ? function(n, t, r, l) {
        MSApp.execUnsafeLocalFunction(function() {
            return e(n, t, r, l)
        })
    } : e
}(function(e, n) {
    if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML" in e) e.innerHTML = n;
    else {
        for (Sr = Sr || document.createElement("div"), Sr.innerHTML = "<svg>" + n.valueOf().toString() + "</svg>", n = Sr.firstChild; e.firstChild;) e.removeChild(e.firstChild);
        for (; n.firstChild;) e.appendChild(n.firstChild)
    }
});

function Xt(e, n) {
    if (n) {
        var t = e.firstChild;
        if (t && t === e.lastChild && t.nodeType === 3) {
            t.nodeValue = n;
            return
        }
    }
    e.textContent = n
}
var At = {
        animationIterationCount: !0,
        aspectRatio: !0,
        borderImageOutset: !0,
        borderImageSlice: !0,
        borderImageWidth: !0,
        boxFlex: !0,
        boxFlexGroup: !0,
        boxOrdinalGroup: !0,
        columnCount: !0,
        columns: !0,
        flex: !0,
        flexGrow: !0,
        flexPositive: !0,
        flexShrink: !0,
        flexNegative: !0,
        flexOrder: !0,
        gridArea: !0,
        gridRow: !0,
        gridRowEnd: !0,
        gridRowSpan: !0,
        gridRowStart: !0,
        gridColumn: !0,
        gridColumnEnd: !0,
        gridColumnSpan: !0,
        gridColumnStart: !0,
        fontWeight: !0,
        lineClamp: !0,
        lineHeight: !0,
        opacity: !0,
        order: !0,
        orphans: !0,
        tabSize: !0,
        widows: !0,
        zIndex: !0,
        zoom: !0,
        fillOpacity: !0,
        floodOpacity: !0,
        stopOpacity: !0,
        strokeDasharray: !0,
        strokeDashoffset: !0,
        strokeMiterlimit: !0,
        strokeOpacity: !0,
        strokeWidth: !0
    },
    Zf = ["Webkit", "ms", "Moz", "O"];
Object.keys(At).forEach(function(e) {
    Zf.forEach(function(n) {
        n = n + e.charAt(0).toUpperCase() + e.substring(1), At[n] = At[e]
    })
});

function hs(e, n, t) {
    return n == null || typeof n == "boolean" || n === "" ? "" : t || typeof n != "number" || n === 0 || At.hasOwnProperty(e) && At[e] ? ("" + n).trim() : n + "px"
}

function vs(e, n) {
    e = e.style;
    for (var t in n)
        if (n.hasOwnProperty(t)) {
            var r = t.indexOf("--") === 0,
                l = hs(t, n[t], r);
            t === "float" && (t = "cssFloat"), r ? e.setProperty(t, l) : e[t] = l
        }
}
var Xf = Q({
    menuitem: !0
}, {
    area: !0,
    base: !0,
    br: !0,
    col: !0,
    embed: !0,
    hr: !0,
    img: !0,
    input: !0,
    keygen: !0,
    link: !0,
    meta: !0,
    param: !0,
    source: !0,
    track: !0,
    wbr: !0
});

function Ii(e, n) {
    if (n) {
        if (Xf[e] && (n.children != null || n.dangerouslySetInnerHTML != null)) throw Error(k(137, e));
        if (n.dangerouslySetInnerHTML != null) {
            if (n.children != null) throw Error(k(60));
            if (typeof n.dangerouslySetInnerHTML != "object" || !("__html" in n.dangerouslySetInnerHTML)) throw Error(k(61))
        }
        if (n.style != null && typeof n.style != "object") throw Error(k(62))
    }
}

function Mi(e, n) {
    if (e.indexOf("-") === -1) return typeof n.is == "string";
    switch (e) {
        case "annotation-xml":
        case "color-profile":
        case "font-face":
        case "font-face-src":
        case "font-face-uri":
        case "font-face-format":
        case "font-face-name":
        case "missing-glyph":
            return !1;
        default:
            return !0
    }
}
var Fi = null;

function zo(e) {
    return e = e.target || e.srcElement || window, e.correspondingUseElement && (e = e.correspondingUseElement), e.nodeType === 3 ? e.parentNode : e
}
var Ai = null,
    ut = null,
    at = null;

function Du(e) {
    if (e = mr(e)) {
        if (typeof Ai != "function") throw Error(k(280));
        var n = e.stateNode;
        n && (n = Dl(n), Ai(e.stateNode, e.type, n))
    }
}

function gs(e) {
    ut ? at ? at.push(e) : at = [e] : ut = e
}

function ys() {
    if (ut) {
        var e = ut,
            n = at;
        if (at = ut = null, Du(e), n)
            for (e = 0; e < n.length; e++) Du(n[e])
    }
}

function xs(e, n) {
    return e(n)
}

function ws() {}
var Yl = !1;

function Cs(e, n, t) {
    if (Yl) return e(n, t);
    Yl = !0;
    try {
        return xs(e, n, t)
    } finally {
        Yl = !1, (ut !== null || at !== null) && (ws(), ys())
    }
}

function Yt(e, n) {
    var t = e.stateNode;
    if (t === null) return null;
    var r = Dl(t);
    if (r === null) return null;
    t = r[n];
    e: switch (n) {
        case "onClick":
        case "onClickCapture":
        case "onDoubleClick":
        case "onDoubleClickCapture":
        case "onMouseDown":
        case "onMouseDownCapture":
        case "onMouseMove":
        case "onMouseMoveCapture":
        case "onMouseUp":
        case "onMouseUpCapture":
        case "onMouseEnter":
            (r = !r.disabled) || (e = e.type, r = !(e === "button" || e === "input" || e === "select" || e === "textarea")), e = !r;
            break e;
        default:
            e = !1
    }
    if (e) return null;
    if (t && typeof t != "function") throw Error(k(231, n, typeof t));
    return t
}
var Ui = !1;
if (Ye) try {
    var Et = {};
    Object.defineProperty(Et, "passive", {
        get: function() {
            Ui = !0
        }
    }), window.addEventListener("test", Et, Et), window.removeEventListener("test", Et, Et)
} catch {
    Ui = !1
}

function Yf(e, n, t, r, l, i, o, u, a) {
    var s = Array.prototype.slice.call(arguments, 3);
    try {
        n.apply(t, s)
    } catch (m) {
        this.onError(m)
    }
}
var Ut = !1,
    tl = null,
    rl = !1,
    $i = null,
    Jf = {
        onError: function(e) {
            Ut = !0, tl = e
        }
    };

function qf(e, n, t, r, l, i, o, u, a) {
    Ut = !1, tl = null, Yf.apply(Jf, arguments)
}

function bf(e, n, t, r, l, i, o, u, a) {
    if (qf.apply(this, arguments), Ut) {
        if (Ut) {
            var s = tl;
            Ut = !1, tl = null
        } else throw Error(k(198));
        rl || (rl = !0, $i = s)
    }
}

function Bn(e) {
    var n = e,
        t = e;
    if (e.alternate)
        for (; n.return;) n = n.return;
    else {
        e = n;
        do n = e, n.flags & 4098 && (t = n.return), e = n.return; while (e)
    }
    return n.tag === 3 ? t : null
}

function ks(e) {
    if (e.tag === 13) {
        var n = e.memoizedState;
        if (n === null && (e = e.alternate, e !== null && (n = e.memoizedState)), n !== null) return n.dehydrated
    }
    return null
}

function zu(e) {
    if (Bn(e) !== e) throw Error(k(188))
}

function ed(e) {
    var n = e.alternate;
    if (!n) {
        if (n = Bn(e), n === null) throw Error(k(188));
        return n !== e ? null : e
    }
    for (var t = e, r = n;;) {
        var l = t.return;
        if (l === null) break;
        var i = l.alternate;
        if (i === null) {
            if (r = l.return, r !== null) {
                t = r;
                continue
            }
            break
        }
        if (l.child === i.child) {
            for (i = l.child; i;) {
                if (i === t) return zu(l), e;
                if (i === r) return zu(l), n;
                i = i.sibling
            }
            throw Error(k(188))
        }
        if (t.return !== r.return) t = l, r = i;
        else {
            for (var o = !1, u = l.child; u;) {
                if (u === t) {
                    o = !0, t = l, r = i;
                    break
                }
                if (u === r) {
                    o = !0, r = l, t = i;
                    break
                }
                u = u.sibling
            }
            if (!o) {
                for (u = i.child; u;) {
                    if (u === t) {
                        o = !0, t = i, r = l;
                        break
                    }
                    if (u === r) {
                        o = !0, r = i, t = l;
                        break
                    }
                    u = u.sibling
                }
                if (!o) throw Error(k(189))
            }
        }
        if (t.alternate !== r) throw Error(k(190))
    }
    if (t.tag !== 3) throw Error(k(188));
    return t.stateNode.current === t ? e : n
}

function Ss(e) {
    return e = ed(e), e !== null ? Es(e) : null
}

function Es(e) {
    if (e.tag === 5 || e.tag === 6) return e;
    for (e = e.child; e !== null;) {
        var n = Es(e);
        if (n !== null) return n;
        e = e.sibling
    }
    return null
}
var _s = Ce.unstable_scheduleCallback,
    Ou = Ce.unstable_cancelCallback,
    nd = Ce.unstable_shouldYield,
    td = Ce.unstable_requestPaint,
    Z = Ce.unstable_now,
    rd = Ce.unstable_getCurrentPriorityLevel,
    Oo = Ce.unstable_ImmediatePriority,
    Ns = Ce.unstable_UserBlockingPriority,
    ll = Ce.unstable_NormalPriority,
    ld = Ce.unstable_LowPriority,
    js = Ce.unstable_IdlePriority,
    jl = null,
    Be = null;

function id(e) {
    if (Be && typeof Be.onCommitFiberRoot == "function") try {
        Be.onCommitFiberRoot(jl, e, void 0, (e.current.flags & 128) === 128)
    } catch {}
}
var Ie = Math.clz32 ? Math.clz32 : ad,
    od = Math.log,
    ud = Math.LN2;

function ad(e) {
    return e >>>= 0, e === 0 ? 32 : 31 - (od(e) / ud | 0) | 0
}
var Er = 64,
    _r = 4194304;

function Mt(e) {
    switch (e & -e) {
        case 1:
            return 1;
        case 2:
            return 2;
        case 4:
            return 4;
        case 8:
            return 8;
        case 16:
            return 16;
        case 32:
            return 32;
        case 64:
        case 128:
        case 256:
        case 512:
        case 1024:
        case 2048:
        case 4096:
        case 8192:
        case 16384:
        case 32768:
        case 65536:
        case 131072:
        case 262144:
        case 524288:
        case 1048576:
        case 2097152:
            return e & 4194240;
        case 4194304:
        case 8388608:
        case 16777216:
        case 33554432:
        case 67108864:
            return e & 130023424;
        case 134217728:
            return 134217728;
        case 268435456:
            return 268435456;
        case 536870912:
            return 536870912;
        case 1073741824:
            return 1073741824;
        default:
            return e
    }
}

function il(e, n) {
    var t = e.pendingLanes;
    if (t === 0) return 0;
    var r = 0,
        l = e.suspendedLanes,
        i = e.pingedLanes,
        o = t & 268435455;
    if (o !== 0) {
        var u = o & ~l;
        u !== 0 ? r = Mt(u) : (i &= o, i !== 0 && (r = Mt(i)))
    } else o = t & ~l, o !== 0 ? r = Mt(o) : i !== 0 && (r = Mt(i));
    if (r === 0) return 0;
    if (n !== 0 && n !== r && !(n & l) && (l = r & -r, i = n & -n, l >= i || l === 16 && (i & 4194240) !== 0)) return n;
    if (r & 4 && (r |= t & 16), n = e.entangledLanes, n !== 0)
        for (e = e.entanglements, n &= r; 0 < n;) t = 31 - Ie(n), l = 1 << t, r |= e[t], n &= ~l;
    return r
}

function sd(e, n) {
    switch (e) {
        case 1:
        case 2:
        case 4:
            return n + 250;
        case 8:
        case 16:
        case 32:
        case 64:
        case 128:
        case 256:
        case 512:
        case 1024:
        case 2048:
        case 4096:
        case 8192:
        case 16384:
        case 32768:
        case 65536:
        case 131072:
        case 262144:
        case 524288:
        case 1048576:
        case 2097152:
            return n + 5e3;
        case 4194304:
        case 8388608:
        case 16777216:
        case 33554432:
        case 67108864:
            return -1;
        case 134217728:
        case 268435456:
        case 536870912:
        case 1073741824:
            return -1;
        default:
            return -1
    }
}

function cd(e, n) {
    for (var t = e.suspendedLanes, r = e.pingedLanes, l = e.expirationTimes, i = e.pendingLanes; 0 < i;) {
        var o = 31 - Ie(i),
            u = 1 << o,
            a = l[o];
        a === -1 ? (!(u & t) || u & r) && (l[o] = sd(u, n)) : a <= n && (e.expiredLanes |= u), i &= ~u
    }
}

function Bi(e) {
    return e = e.pendingLanes & -1073741825, e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}

function Ls() {
    var e = Er;
    return Er <<= 1, !(Er & 4194240) && (Er = 64), e
}

function Jl(e) {
    for (var n = [], t = 0; 31 > t; t++) n.push(e);
    return n
}

function dr(e, n, t) {
    e.pendingLanes |= n, n !== 536870912 && (e.suspendedLanes = 0, e.pingedLanes = 0), e = e.eventTimes, n = 31 - Ie(n), e[n] = t
}

function fd(e, n) {
    var t = e.pendingLanes & ~n;
    e.pendingLanes = n, e.suspendedLanes = 0, e.pingedLanes = 0, e.expiredLanes &= n, e.mutableReadLanes &= n, e.entangledLanes &= n, n = e.entanglements;
    var r = e.eventTimes;
    for (e = e.expirationTimes; 0 < t;) {
        var l = 31 - Ie(t),
            i = 1 << l;
        n[l] = 0, r[l] = -1, e[l] = -1, t &= ~i
    }
}

function Ro(e, n) {
    var t = e.entangledLanes |= n;
    for (e = e.entanglements; t;) {
        var r = 31 - Ie(t),
            l = 1 << r;
        l & n | e[r] & n && (e[r] |= n), t &= ~l
    }
}
var M = 0;

function Ts(e) {
    return e &= -e, 1 < e ? 4 < e ? e & 268435455 ? 16 : 536870912 : 4 : 1
}
var Ps, Io, Ds, zs, Os, Hi = !1,
    Nr = [],
    cn = null,
    fn = null,
    dn = null,
    Jt = new Map,
    qt = new Map,
    on = [],
    dd = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");

function Ru(e, n) {
    switch (e) {
        case "focusin":
        case "focusout":
            cn = null;
            break;
        case "dragenter":
        case "dragleave":
            fn = null;
            break;
        case "mouseover":
        case "mouseout":
            dn = null;
            break;
        case "pointerover":
        case "pointerout":
            Jt.delete(n.pointerId);
            break;
        case "gotpointercapture":
        case "lostpointercapture":
            qt.delete(n.pointerId)
    }
}

function _t(e, n, t, r, l, i) {
    return e === null || e.nativeEvent !== i ? (e = {
        blockedOn: n,
        domEventName: t,
        eventSystemFlags: r,
        nativeEvent: i,
        targetContainers: [l]
    }, n !== null && (n = mr(n), n !== null && Io(n)), e) : (e.eventSystemFlags |= r, n = e.targetContainers, l !== null && n.indexOf(l) === -1 && n.push(l), e)
}

function pd(e, n, t, r, l) {
    switch (n) {
        case "focusin":
            return cn = _t(cn, e, n, t, r, l), !0;
        case "dragenter":
            return fn = _t(fn, e, n, t, r, l), !0;
        case "mouseover":
            return dn = _t(dn, e, n, t, r, l), !0;
        case "pointerover":
            var i = l.pointerId;
            return Jt.set(i, _t(Jt.get(i) || null, e, n, t, r, l)), !0;
        case "gotpointercapture":
            return i = l.pointerId, qt.set(i, _t(qt.get(i) || null, e, n, t, r, l)), !0
    }
    return !1
}

function Rs(e) {
    var n = Tn(e.target);
    if (n !== null) {
        var t = Bn(n);
        if (t !== null) {
            if (n = t.tag, n === 13) {
                if (n = ks(t), n !== null) {
                    e.blockedOn = n, Os(e.priority, function() {
                        Ds(t)
                    });
                    return
                }
            } else if (n === 3 && t.stateNode.current.memoizedState.isDehydrated) {
                e.blockedOn = t.tag === 3 ? t.stateNode.containerInfo : null;
                return
            }
        }
    }
    e.blockedOn = null
}

function Qr(e) {
    if (e.blockedOn !== null) return !1;
    for (var n = e.targetContainers; 0 < n.length;) {
        var t = Vi(e.domEventName, e.eventSystemFlags, n[0], e.nativeEvent);
        if (t === null) {
            t = e.nativeEvent;
            var r = new t.constructor(t.type, t);
            Fi = r, t.target.dispatchEvent(r), Fi = null
        } else return n = mr(t), n !== null && Io(n), e.blockedOn = t, !1;
        n.shift()
    }
    return !0
}

function Iu(e, n, t) {
    Qr(e) && t.delete(n)
}

function md() {
    Hi = !1, cn !== null && Qr(cn) && (cn = null), fn !== null && Qr(fn) && (fn = null), dn !== null && Qr(dn) && (dn = null), Jt.forEach(Iu), qt.forEach(Iu)
}

function Nt(e, n) {
    e.blockedOn === n && (e.blockedOn = null, Hi || (Hi = !0, Ce.unstable_scheduleCallback(Ce.unstable_NormalPriority, md)))
}

function bt(e) {
    function n(l) {
        return Nt(l, e)
    }
    if (0 < Nr.length) {
        Nt(Nr[0], e);
        for (var t = 1; t < Nr.length; t++) {
            var r = Nr[t];
            r.blockedOn === e && (r.blockedOn = null)
        }
    }
    for (cn !== null && Nt(cn, e), fn !== null && Nt(fn, e), dn !== null && Nt(dn, e), Jt.forEach(n), qt.forEach(n), t = 0; t < on.length; t++) r = on[t], r.blockedOn === e && (r.blockedOn = null);
    for (; 0 < on.length && (t = on[0], t.blockedOn === null);) Rs(t), t.blockedOn === null && on.shift()
}
var st = en.ReactCurrentBatchConfig,
    ol = !0;

function hd(e, n, t, r) {
    var l = M,
        i = st.transition;
    st.transition = null;
    try {
        M = 1, Mo(e, n, t, r)
    } finally {
        M = l, st.transition = i
    }
}

function vd(e, n, t, r) {
    var l = M,
        i = st.transition;
    st.transition = null;
    try {
        M = 4, Mo(e, n, t, r)
    } finally {
        M = l, st.transition = i
    }
}

function Mo(e, n, t, r) {
    if (ol) {
        var l = Vi(e, n, t, r);
        if (l === null) ui(e, n, r, ul, t), Ru(e, r);
        else if (pd(l, e, n, t, r)) r.stopPropagation();
        else if (Ru(e, r), n & 4 && -1 < dd.indexOf(e)) {
            for (; l !== null;) {
                var i = mr(l);
                if (i !== null && Ps(i), i = Vi(e, n, t, r), i === null && ui(e, n, r, ul, t), i === l) break;
                l = i
            }
            l !== null && r.stopPropagation()
        } else ui(e, n, r, null, t)
    }
}
var ul = null;

function Vi(e, n, t, r) {
    if (ul = null, e = zo(r), e = Tn(e), e !== null)
        if (n = Bn(e), n === null) e = null;
        else if (t = n.tag, t === 13) {
            if (e = ks(n), e !== null) return e;
            e = null
        } else if (t === 3) {
            if (n.stateNode.current.memoizedState.isDehydrated) return n.tag === 3 ? n.stateNode.containerInfo : null;
            e = null
        } else n !== e && (e = null);
    return ul = e, null
}

function Is(e) {
    switch (e) {
        case "cancel":
        case "click":
        case "close":
        case "contextmenu":
        case "copy":
        case "cut":
        case "auxclick":
        case "dblclick":
        case "dragend":
        case "dragstart":
        case "drop":
        case "focusin":
        case "focusout":
        case "input":
        case "invalid":
        case "keydown":
        case "keypress":
        case "keyup":
        case "mousedown":
        case "mouseup":
        case "paste":
        case "pause":
        case "play":
        case "pointercancel":
        case "pointerdown":
        case "pointerup":
        case "ratechange":
        case "reset":
        case "resize":
        case "seeked":
        case "submit":
        case "touchcancel":
        case "touchend":
        case "touchstart":
        case "volumechange":
        case "change":
        case "selectionchange":
        case "textInput":
        case "compositionstart":
        case "compositionend":
        case "compositionupdate":
        case "beforeblur":
        case "afterblur":
        case "beforeinput":
        case "blur":
        case "fullscreenchange":
        case "focus":
        case "hashchange":
        case "popstate":
        case "select":
        case "selectstart":
            return 1;
        case "drag":
        case "dragenter":
        case "dragexit":
        case "dragleave":
        case "dragover":
        case "mousemove":
        case "mouseout":
        case "mouseover":
        case "pointermove":
        case "pointerout":
        case "pointerover":
        case "scroll":
        case "toggle":
        case "touchmove":
        case "wheel":
        case "mouseenter":
        case "mouseleave":
        case "pointerenter":
        case "pointerleave":
            return 4;
        case "message":
            switch (rd()) {
                case Oo:
                    return 1;
                case Ns:
                    return 4;
                case ll:
                case ld:
                    return 16;
                case js:
                    return 536870912;
                default:
                    return 16
            }
        default:
            return 16
    }
}
var an = null,
    Fo = null,
    Kr = null;

function Ms() {
    if (Kr) return Kr;
    var e, n = Fo,
        t = n.length,
        r, l = "value" in an ? an.value : an.textContent,
        i = l.length;
    for (e = 0; e < t && n[e] === l[e]; e++);
    var o = t - e;
    for (r = 1; r <= o && n[t - r] === l[i - r]; r++);
    return Kr = l.slice(e, 1 < r ? 1 - r : void 0)
}

function Gr(e) {
    var n = e.keyCode;
    return "charCode" in e ? (e = e.charCode, e === 0 && n === 13 && (e = 13)) : e = n, e === 10 && (e = 13), 32 <= e || e === 13 ? e : 0
}

function jr() {
    return !0
}

function Mu() {
    return !1
}

function Se(e) {
    function n(t, r, l, i, o) {
        this._reactName = t, this._targetInst = l, this.type = r, this.nativeEvent = i, this.target = o, this.currentTarget = null;
        for (var u in e) e.hasOwnProperty(u) && (t = e[u], this[u] = t ? t(i) : i[u]);
        return this.isDefaultPrevented = (i.defaultPrevented != null ? i.defaultPrevented : i.returnValue === !1) ? jr : Mu, this.isPropagationStopped = Mu, this
    }
    return Q(n.prototype, {
        preventDefault: function() {
            this.defaultPrevented = !0;
            var t = this.nativeEvent;
            t && (t.preventDefault ? t.preventDefault() : typeof t.returnValue != "unknown" && (t.returnValue = !1), this.isDefaultPrevented = jr)
        },
        stopPropagation: function() {
            var t = this.nativeEvent;
            t && (t.stopPropagation ? t.stopPropagation() : typeof t.cancelBubble != "unknown" && (t.cancelBubble = !0), this.isPropagationStopped = jr)
        },
        persist: function() {},
        isPersistent: jr
    }), n
}
var Ct = {
        eventPhase: 0,
        bubbles: 0,
        cancelable: 0,
        timeStamp: function(e) {
            return e.timeStamp || Date.now()
        },
        defaultPrevented: 0,
        isTrusted: 0
    },
    Ao = Se(Ct),
    pr = Q({}, Ct, {
        view: 0,
        detail: 0
    }),
    gd = Se(pr),
    ql, bl, jt, Ll = Q({}, pr, {
        screenX: 0,
        screenY: 0,
        clientX: 0,
        clientY: 0,
        pageX: 0,
        pageY: 0,
        ctrlKey: 0,
        shiftKey: 0,
        altKey: 0,
        metaKey: 0,
        getModifierState: Uo,
        button: 0,
        buttons: 0,
        relatedTarget: function(e) {
            return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
        },
        movementX: function(e) {
            return "movementX" in e ? e.movementX : (e !== jt && (jt && e.type === "mousemove" ? (ql = e.screenX - jt.screenX, bl = e.screenY - jt.screenY) : bl = ql = 0, jt = e), ql)
        },
        movementY: function(e) {
            return "movementY" in e ? e.movementY : bl
        }
    }),
    Fu = Se(Ll),
    yd = Q({}, Ll, {
        dataTransfer: 0
    }),
    xd = Se(yd),
    wd = Q({}, pr, {
        relatedTarget: 0
    }),
    ei = Se(wd),
    Cd = Q({}, Ct, {
        animationName: 0,
        elapsedTime: 0,
        pseudoElement: 0
    }),
    kd = Se(Cd),
    Sd = Q({}, Ct, {
        clipboardData: function(e) {
            return "clipboardData" in e ? e.clipboardData : window.clipboardData
        }
    }),
    Ed = Se(Sd),
    _d = Q({}, Ct, {
        data: 0
    }),
    Au = Se(_d),
    Nd = {
        Esc: "Escape",
        Spacebar: " ",
        Left: "ArrowLeft",
        Up: "ArrowUp",
        Right: "ArrowRight",
        Down: "ArrowDown",
        Del: "Delete",
        Win: "OS",
        Menu: "ContextMenu",
        Apps: "ContextMenu",
        Scroll: "ScrollLock",
        MozPrintableKey: "Unidentified"
    },
    jd = {
        8: "Backspace",
        9: "Tab",
        12: "Clear",
        13: "Enter",
        16: "Shift",
        17: "Control",
        18: "Alt",
        19: "Pause",
        20: "CapsLock",
        27: "Escape",
        32: " ",
        33: "PageUp",
        34: "PageDown",
        35: "End",
        36: "Home",
        37: "ArrowLeft",
        38: "ArrowUp",
        39: "ArrowRight",
        40: "ArrowDown",
        45: "Insert",
        46: "Delete",
        112: "F1",
        113: "F2",
        114: "F3",
        115: "F4",
        116: "F5",
        117: "F6",
        118: "F7",
        119: "F8",
        120: "F9",
        121: "F10",
        122: "F11",
        123: "F12",
        144: "NumLock",
        145: "ScrollLock",
        224: "Meta"
    },
    Ld = {
        Alt: "altKey",
        Control: "ctrlKey",
        Meta: "metaKey",
        Shift: "shiftKey"
    };

function Td(e) {
    var n = this.nativeEvent;
    return n.getModifierState ? n.getModifierState(e) : (e = Ld[e]) ? !!n[e] : !1
}

function Uo() {
    return Td
}
var Pd = Q({}, pr, {
        key: function(e) {
            if (e.key) {
                var n = Nd[e.key] || e.key;
                if (n !== "Unidentified") return n
            }
            return e.type === "keypress" ? (e = Gr(e), e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? jd[e.keyCode] || "Unidentified" : ""
        },
        code: 0,
        location: 0,
        ctrlKey: 0,
        shiftKey: 0,
        altKey: 0,
        metaKey: 0,
        repeat: 0,
        locale: 0,
        getModifierState: Uo,
        charCode: function(e) {
            return e.type === "keypress" ? Gr(e) : 0
        },
        keyCode: function(e) {
            return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
        },
        which: function(e) {
            return e.type === "keypress" ? Gr(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
        }
    }),
    Dd = Se(Pd),
    zd = Q({}, Ll, {
        pointerId: 0,
        width: 0,
        height: 0,
        pressure: 0,
        tangentialPressure: 0,
        tiltX: 0,
        tiltY: 0,
        twist: 0,
        pointerType: 0,
        isPrimary: 0
    }),
    Uu = Se(zd),
    Od = Q({}, pr, {
        touches: 0,
        targetTouches: 0,
        changedTouches: 0,
        altKey: 0,
        metaKey: 0,
        ctrlKey: 0,
        shiftKey: 0,
        getModifierState: Uo
    }),
    Rd = Se(Od),
    Id = Q({}, Ct, {
        propertyName: 0,
        elapsedTime: 0,
        pseudoElement: 0
    }),
    Md = Se(Id),
    Fd = Q({}, Ll, {
        deltaX: function(e) {
            return "deltaX" in e ? e.deltaX : "wheelDeltaX" in e ? -e.wheelDeltaX : 0
        },
        deltaY: function(e) {
            return "deltaY" in e ? e.deltaY : "wheelDeltaY" in e ? -e.wheelDeltaY : "wheelDelta" in e ? -e.wheelDelta : 0
        },
        deltaZ: 0,
        deltaMode: 0
    }),
    Ad = Se(Fd),
    Ud = [9, 13, 27, 32],
    $o = Ye && "CompositionEvent" in window,
    $t = null;
Ye && "documentMode" in document && ($t = document.documentMode);
var $d = Ye && "TextEvent" in window && !$t,
    Fs = Ye && (!$o || $t && 8 < $t && 11 >= $t),
    $u = String.fromCharCode(32),
    Bu = !1;

function As(e, n) {
    switch (e) {
        case "keyup":
            return Ud.indexOf(n.keyCode) !== -1;
        case "keydown":
            return n.keyCode !== 229;
        case "keypress":
        case "mousedown":
        case "focusout":
            return !0;
        default:
            return !1
    }
}

function Us(e) {
    return e = e.detail, typeof e == "object" && "data" in e ? e.data : null
}
var Xn = !1;

function Bd(e, n) {
    switch (e) {
        case "compositionend":
            return Us(n);
        case "keypress":
            return n.which !== 32 ? null : (Bu = !0, $u);
        case "textInput":
            return e = n.data, e === $u && Bu ? null : e;
        default:
            return null
    }
}

function Hd(e, n) {
    if (Xn) return e === "compositionend" || !$o && As(e, n) ? (e = Ms(), Kr = Fo = an = null, Xn = !1, e) : null;
    switch (e) {
        case "paste":
            return null;
        case "keypress":
            if (!(n.ctrlKey || n.altKey || n.metaKey) || n.ctrlKey && n.altKey) {
                if (n.char && 1 < n.char.length) return n.char;
                if (n.which) return String.fromCharCode(n.which)
            }
            return null;
        case "compositionend":
            return Fs && n.locale !== "ko" ? null : n.data;
        default:
            return null
    }
}
var Vd = {
    color: !0,
    date: !0,
    datetime: !0,
    "datetime-local": !0,
    email: !0,
    month: !0,
    number: !0,
    password: !0,
    range: !0,
    search: !0,
    tel: !0,
    text: !0,
    time: !0,
    url: !0,
    week: !0
};

function Hu(e) {
    var n = e && e.nodeName && e.nodeName.toLowerCase();
    return n === "input" ? !!Vd[e.type] : n === "textarea"
}

function $s(e, n, t, r) {
    gs(r), n = al(n, "onChange"), 0 < n.length && (t = new Ao("onChange", "change", null, t, r), e.push({
        event: t,
        listeners: n
    }))
}
var Bt = null,
    er = null;

function Wd(e) {
    Js(e, 0)
}

function Tl(e) {
    var n = qn(e);
    if (cs(n)) return e
}

function Qd(e, n) {
    if (e === "change") return n
}
var Bs = !1;
if (Ye) {
    var ni;
    if (Ye) {
        var ti = "oninput" in document;
        if (!ti) {
            var Vu = document.createElement("div");
            Vu.setAttribute("oninput", "return;"), ti = typeof Vu.oninput == "function"
        }
        ni = ti
    } else ni = !1;
    Bs = ni && (!document.documentMode || 9 < document.documentMode)
}

function Wu() {
    Bt && (Bt.detachEvent("onpropertychange", Hs), er = Bt = null)
}

function Hs(e) {
    if (e.propertyName === "value" && Tl(er)) {
        var n = [];
        $s(n, er, e, zo(e)), Cs(Wd, n)
    }
}

function Kd(e, n, t) {
    e === "focusin" ? (Wu(), Bt = n, er = t, Bt.attachEvent("onpropertychange", Hs)) : e === "focusout" && Wu()
}

function Gd(e) {
    if (e === "selectionchange" || e === "keyup" || e === "keydown") return Tl(er)
}

function Zd(e, n) {
    if (e === "click") return Tl(n)
}

function Xd(e, n) {
    if (e === "input" || e === "change") return Tl(n)
}

function Yd(e, n) {
    return e === n && (e !== 0 || 1 / e === 1 / n) || e !== e && n !== n
}
var Fe = typeof Object.is == "function" ? Object.is : Yd;

function nr(e, n) {
    if (Fe(e, n)) return !0;
    if (typeof e != "object" || e === null || typeof n != "object" || n === null) return !1;
    var t = Object.keys(e),
        r = Object.keys(n);
    if (t.length !== r.length) return !1;
    for (r = 0; r < t.length; r++) {
        var l = t[r];
        if (!_i.call(n, l) || !Fe(e[l], n[l])) return !1
    }
    return !0
}

function Qu(e) {
    for (; e && e.firstChild;) e = e.firstChild;
    return e
}

function Ku(e, n) {
    var t = Qu(e);
    e = 0;
    for (var r; t;) {
        if (t.nodeType === 3) {
            if (r = e + t.textContent.length, e <= n && r >= n) return {
                node: t,
                offset: n - e
            };
            e = r
        }
        e: {
            for (; t;) {
                if (t.nextSibling) {
                    t = t.nextSibling;
                    break e
                }
                t = t.parentNode
            }
            t = void 0
        }
        t = Qu(t)
    }
}

function Vs(e, n) {
    return e && n ? e === n ? !0 : e && e.nodeType === 3 ? !1 : n && n.nodeType === 3 ? Vs(e, n.parentNode) : "contains" in e ? e.contains(n) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(n) & 16) : !1 : !1
}

function Ws() {
    for (var e = window, n = nl(); n instanceof e.HTMLIFrameElement;) {
        try {
            var t = typeof n.contentWindow.location.href == "string"
        } catch {
            t = !1
        }
        if (t) e = n.contentWindow;
        else break;
        n = nl(e.document)
    }
    return n
}

function Bo(e) {
    var n = e && e.nodeName && e.nodeName.toLowerCase();
    return n && (n === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || n === "textarea" || e.contentEditable === "true")
}

function Jd(e) {
    var n = Ws(),
        t = e.focusedElem,
        r = e.selectionRange;
    if (n !== t && t && t.ownerDocument && Vs(t.ownerDocument.documentElement, t)) {
        if (r !== null && Bo(t)) {
            if (n = r.start, e = r.end, e === void 0 && (e = n), "selectionStart" in t) t.selectionStart = n, t.selectionEnd = Math.min(e, t.value.length);
            else if (e = (n = t.ownerDocument || document) && n.defaultView || window, e.getSelection) {
                e = e.getSelection();
                var l = t.textContent.length,
                    i = Math.min(r.start, l);
                r = r.end === void 0 ? i : Math.min(r.end, l), !e.extend && i > r && (l = r, r = i, i = l), l = Ku(t, i);
                var o = Ku(t, r);
                l && o && (e.rangeCount !== 1 || e.anchorNode !== l.node || e.anchorOffset !== l.offset || e.focusNode !== o.node || e.focusOffset !== o.offset) && (n = n.createRange(), n.setStart(l.node, l.offset), e.removeAllRanges(), i > r ? (e.addRange(n), e.extend(o.node, o.offset)) : (n.setEnd(o.node, o.offset), e.addRange(n)))
            }
        }
        for (n = [], e = t; e = e.parentNode;) e.nodeType === 1 && n.push({
            element: e,
            left: e.scrollLeft,
            top: e.scrollTop
        });
        for (typeof t.focus == "function" && t.focus(), t = 0; t < n.length; t++) e = n[t], e.element.scrollLeft = e.left, e.element.scrollTop = e.top
    }
}
var qd = Ye && "documentMode" in document && 11 >= document.documentMode,
    Yn = null,
    Wi = null,
    Ht = null,
    Qi = !1;

function Gu(e, n, t) {
    var r = t.window === t ? t.document : t.nodeType === 9 ? t : t.ownerDocument;
    Qi || Yn == null || Yn !== nl(r) || (r = Yn, "selectionStart" in r && Bo(r) ? r = {
        start: r.selectionStart,
        end: r.selectionEnd
    } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(), r = {
        anchorNode: r.anchorNode,
        anchorOffset: r.anchorOffset,
        focusNode: r.focusNode,
        focusOffset: r.focusOffset
    }), Ht && nr(Ht, r) || (Ht = r, r = al(Wi, "onSelect"), 0 < r.length && (n = new Ao("onSelect", "select", null, n, t), e.push({
        event: n,
        listeners: r
    }), n.target = Yn)))
}

function Lr(e, n) {
    var t = {};
    return t[e.toLowerCase()] = n.toLowerCase(), t["Webkit" + e] = "webkit" + n, t["Moz" + e] = "moz" + n, t
}
var Jn = {
        animationend: Lr("Animation", "AnimationEnd"),
        animationiteration: Lr("Animation", "AnimationIteration"),
        animationstart: Lr("Animation", "AnimationStart"),
        transitionend: Lr("Transition", "TransitionEnd")
    },
    ri = {},
    Qs = {};
Ye && (Qs = document.createElement("div").style, "AnimationEvent" in window || (delete Jn.animationend.animation, delete Jn.animationiteration.animation, delete Jn.animationstart.animation), "TransitionEvent" in window || delete Jn.transitionend.transition);

function Pl(e) {
    if (ri[e]) return ri[e];
    if (!Jn[e]) return e;
    var n = Jn[e],
        t;
    for (t in n)
        if (n.hasOwnProperty(t) && t in Qs) return ri[e] = n[t];
    return e
}
var Ks = Pl("animationend"),
    Gs = Pl("animationiteration"),
    Zs = Pl("animationstart"),
    Xs = Pl("transitionend"),
    Ys = new Map,
    Zu = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");

function wn(e, n) {
    Ys.set(e, n), $n(n, [e])
}
for (var li = 0; li < Zu.length; li++) {
    var ii = Zu[li],
        bd = ii.toLowerCase(),
        e1 = ii[0].toUpperCase() + ii.slice(1);
    wn(bd, "on" + e1)
}
wn(Ks, "onAnimationEnd");
wn(Gs, "onAnimationIteration");
wn(Zs, "onAnimationStart");
wn("dblclick", "onDoubleClick");
wn("focusin", "onFocus");
wn("focusout", "onBlur");
wn(Xs, "onTransitionEnd");
dt("onMouseEnter", ["mouseout", "mouseover"]);
dt("onMouseLeave", ["mouseout", "mouseover"]);
dt("onPointerEnter", ["pointerout", "pointerover"]);
dt("onPointerLeave", ["pointerout", "pointerover"]);
$n("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
$n("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
$n("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
$n("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
$n("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
$n("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var Ft = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),
    n1 = new Set("cancel close invalid load scroll toggle".split(" ").concat(Ft));

function Xu(e, n, t) {
    var r = e.type || "unknown-event";
    e.currentTarget = t, bf(r, n, void 0, e), e.currentTarget = null
}

function Js(e, n) {
    n = (n & 4) !== 0;
    for (var t = 0; t < e.length; t++) {
        var r = e[t],
            l = r.event;
        r = r.listeners;
        e: {
            var i = void 0;
            if (n)
                for (var o = r.length - 1; 0 <= o; o--) {
                    var u = r[o],
                        a = u.instance,
                        s = u.currentTarget;
                    if (u = u.listener, a !== i && l.isPropagationStopped()) break e;
                    Xu(l, u, s), i = a
                } else
                for (o = 0; o < r.length; o++) {
                    if (u = r[o], a = u.instance, s = u.currentTarget, u = u.listener, a !== i && l.isPropagationStopped()) break e;
                    Xu(l, u, s), i = a
                }
        }
    }
    if (rl) throw e = $i, rl = !1, $i = null, e
}

function $(e, n) {
    var t = n[Yi];
    t === void 0 && (t = n[Yi] = new Set);
    var r = e + "__bubble";
    t.has(r) || (qs(n, e, 2, !1), t.add(r))
}

function oi(e, n, t) {
    var r = 0;
    n && (r |= 4), qs(t, e, r, n)
}
var Tr = "_reactListening" + Math.random().toString(36).slice(2);

function tr(e) {
    if (!e[Tr]) {
        e[Tr] = !0, is.forEach(function(t) {
            t !== "selectionchange" && (n1.has(t) || oi(t, !1, e), oi(t, !0, e))
        });
        var n = e.nodeType === 9 ? e : e.ownerDocument;
        n === null || n[Tr] || (n[Tr] = !0, oi("selectionchange", !1, n))
    }
}

function qs(e, n, t, r) {
    switch (Is(n)) {
        case 1:
            var l = hd;
            break;
        case 4:
            l = vd;
            break;
        default:
            l = Mo
    }
    t = l.bind(null, n, t, e), l = void 0, !Ui || n !== "touchstart" && n !== "touchmove" && n !== "wheel" || (l = !0), r ? l !== void 0 ? e.addEventListener(n, t, {
        capture: !0,
        passive: l
    }) : e.addEventListener(n, t, !0) : l !== void 0 ? e.addEventListener(n, t, {
        passive: l
    }) : e.addEventListener(n, t, !1)
}

function ui(e, n, t, r, l) {
    var i = r;
    if (!(n & 1) && !(n & 2) && r !== null) e: for (;;) {
        if (r === null) return;
        var o = r.tag;
        if (o === 3 || o === 4) {
            var u = r.stateNode.containerInfo;
            if (u === l || u.nodeType === 8 && u.parentNode === l) break;
            if (o === 4)
                for (o = r.return; o !== null;) {
                    var a = o.tag;
                    if ((a === 3 || a === 4) && (a = o.stateNode.containerInfo, a === l || a.nodeType === 8 && a.parentNode === l)) return;
                    o = o.return
                }
            for (; u !== null;) {
                if (o = Tn(u), o === null) return;
                if (a = o.tag, a === 5 || a === 6) {
                    r = i = o;
                    continue e
                }
                u = u.parentNode
            }
        }
        r = r.return
    }
    Cs(function() {
        var s = i,
            m = zo(t),
            v = [];
        e: {
            var h = Ys.get(e);
            if (h !== void 0) {
                var C = Ao,
                    g = e;
                switch (e) {
                    case "keypress":
                        if (Gr(t) === 0) break e;
                    case "keydown":
                    case "keyup":
                        C = Dd;
                        break;
                    case "focusin":
                        g = "focus", C = ei;
                        break;
                    case "focusout":
                        g = "blur", C = ei;
                        break;
                    case "beforeblur":
                    case "afterblur":
                        C = ei;
                        break;
                    case "click":
                        if (t.button === 2) break e;
                    case "auxclick":
                    case "dblclick":
                    case "mousedown":
                    case "mousemove":
                    case "mouseup":
                    case "mouseout":
                    case "mouseover":
                    case "contextmenu":
                        C = Fu;
                        break;
                    case "drag":
                    case "dragend":
                    case "dragenter":
                    case "dragexit":
                    case "dragleave":
                    case "dragover":
                    case "dragstart":
                    case "drop":
                        C = xd;
                        break;
                    case "touchcancel":
                    case "touchend":
                    case "touchmove":
                    case "touchstart":
                        C = Rd;
                        break;
                    case Ks:
                    case Gs:
                    case Zs:
                        C = kd;
                        break;
                    case Xs:
                        C = Md;
                        break;
                    case "scroll":
                        C = gd;
                        break;
                    case "wheel":
                        C = Ad;
                        break;
                    case "copy":
                    case "cut":
                    case "paste":
                        C = Ed;
                        break;
                    case "gotpointercapture":
                    case "lostpointercapture":
                    case "pointercancel":
                    case "pointerdown":
                    case "pointermove":
                    case "pointerout":
                    case "pointerover":
                    case "pointerup":
                        C = Uu
                }
                var x = (n & 4) !== 0,
                    L = !x && e === "scroll",
                    f = x ? h !== null ? h + "Capture" : null : h;
                x = [];
                for (var c = s, d; c !== null;) {
                    d = c;
                    var y = d.stateNode;
                    if (d.tag === 5 && y !== null && (d = y, f !== null && (y = Yt(c, f), y != null && x.push(rr(c, y, d)))), L) break;
                    c = c.return
                }
                0 < x.length && (h = new C(h, g, null, t, m), v.push({
                    event: h,
                    listeners: x
                }))
            }
        }
        if (!(n & 7)) {
            e: {
                if (h = e === "mouseover" || e === "pointerover", C = e === "mouseout" || e === "pointerout", h && t !== Fi && (g = t.relatedTarget || t.fromElement) && (Tn(g) || g[Je])) break e;
                if ((C || h) && (h = m.window === m ? m : (h = m.ownerDocument) ? h.defaultView || h.parentWindow : window, C ? (g = t.relatedTarget || t.toElement, C = s, g = g ? Tn(g) : null, g !== null && (L = Bn(g), g !== L || g.tag !== 5 && g.tag !== 6) && (g = null)) : (C = null, g = s), C !== g)) {
                    if (x = Fu, y = "onMouseLeave", f = "onMouseEnter", c = "mouse", (e === "pointerout" || e === "pointerover") && (x = Uu, y = "onPointerLeave", f = "onPointerEnter", c = "pointer"), L = C == null ? h : qn(C), d = g == null ? h : qn(g), h = new x(y, c + "leave", C, t, m), h.target = L, h.relatedTarget = d, y = null, Tn(m) === s && (x = new x(f, c + "enter", g, t, m), x.target = d, x.relatedTarget = L, y = x), L = y, C && g) n: {
                        for (x = C, f = g, c = 0, d = x; d; d = Vn(d)) c++;
                        for (d = 0, y = f; y; y = Vn(y)) d++;
                        for (; 0 < c - d;) x = Vn(x),
                            c--;
                        for (; 0 < d - c;) f = Vn(f),
                            d--;
                        for (; c--;) {
                            if (x === f || f !== null && x === f.alternate) break n;
                            x = Vn(x), f = Vn(f)
                        }
                        x = null
                    }
                    else x = null;
                    C !== null && Yu(v, h, C, x, !1), g !== null && L !== null && Yu(v, L, g, x, !0)
                }
            }
            e: {
                if (h = s ? qn(s) : window, C = h.nodeName && h.nodeName.toLowerCase(), C === "select" || C === "input" && h.type === "file") var S = Qd;
                else if (Hu(h))
                    if (Bs) S = Xd;
                    else {
                        S = Gd;
                        var E = Kd
                    }
                else(C = h.nodeName) && C.toLowerCase() === "input" && (h.type === "checkbox" || h.type === "radio") && (S = Zd);
                if (S && (S = S(e, s))) {
                    $s(v, S, t, m);
                    break e
                }
                E && E(e, h, s),
                e === "focusout" && (E = h._wrapperState) && E.controlled && h.type === "number" && zi(h, "number", h.value)
            }
            switch (E = s ? qn(s) : window, e) {
                case "focusin":
                    (Hu(E) || E.contentEditable === "true") && (Yn = E, Wi = s, Ht = null);
                    break;
                case "focusout":
                    Ht = Wi = Yn = null;
                    break;
                case "mousedown":
                    Qi = !0;
                    break;
                case "contextmenu":
                case "mouseup":
                case "dragend":
                    Qi = !1, Gu(v, t, m);
                    break;
                case "selectionchange":
                    if (qd) break;
                case "keydown":
                case "keyup":
                    Gu(v, t, m)
            }
            var w;
            if ($o) e: {
                switch (e) {
                    case "compositionstart":
                        var _ = "onCompositionStart";
                        break e;
                    case "compositionend":
                        _ = "onCompositionEnd";
                        break e;
                    case "compositionupdate":
                        _ = "onCompositionUpdate";
                        break e
                }
                _ = void 0
            }
            else Xn ? As(e, t) && (_ = "onCompositionEnd") : e === "keydown" && t.keyCode === 229 && (_ = "onCompositionStart");_ && (Fs && t.locale !== "ko" && (Xn || _ !== "onCompositionStart" ? _ === "onCompositionEnd" && Xn && (w = Ms()) : (an = m, Fo = "value" in an ? an.value : an.textContent, Xn = !0)), E = al(s, _), 0 < E.length && (_ = new Au(_, e, null, t, m), v.push({
                event: _,
                listeners: E
            }), w ? _.data = w : (w = Us(t), w !== null && (_.data = w)))),
            (w = $d ? Bd(e, t) : Hd(e, t)) && (s = al(s, "onBeforeInput"), 0 < s.length && (m = new Au("onBeforeInput", "beforeinput", null, t, m), v.push({
                event: m,
                listeners: s
            }), m.data = w))
        }
        Js(v, n)
    })
}

function rr(e, n, t) {
    return {
        instance: e,
        listener: n,
        currentTarget: t
    }
}

function al(e, n) {
    for (var t = n + "Capture", r = []; e !== null;) {
        var l = e,
            i = l.stateNode;
        l.tag === 5 && i !== null && (l = i, i = Yt(e, t), i != null && r.unshift(rr(e, i, l)), i = Yt(e, n), i != null && r.push(rr(e, i, l))), e = e.return
    }
    return r
}

function Vn(e) {
    if (e === null) return null;
    do e = e.return; while (e && e.tag !== 5);
    return e || null
}

function Yu(e, n, t, r, l) {
    for (var i = n._reactName, o = []; t !== null && t !== r;) {
        var u = t,
            a = u.alternate,
            s = u.stateNode;
        if (a !== null && a === r) break;
        u.tag === 5 && s !== null && (u = s, l ? (a = Yt(t, i), a != null && o.unshift(rr(t, a, u))) : l || (a = Yt(t, i), a != null && o.push(rr(t, a, u)))), t = t.return
    }
    o.length !== 0 && e.push({
        event: n,
        listeners: o
    })
}
var t1 = /\r\n?/g,
    r1 = /\u0000|\uFFFD/g;

function Ju(e) {
    return (typeof e == "string" ? e : "" + e).replace(t1, `
`).replace(r1, "")
}

function Pr(e, n, t) {
    if (n = Ju(n), Ju(e) !== n && t) throw Error(k(425))
}

function sl() {}
var Ki = null,
    Gi = null;

function Zi(e, n) {
    return e === "textarea" || e === "noscript" || typeof n.children == "string" || typeof n.children == "number" || typeof n.dangerouslySetInnerHTML == "object" && n.dangerouslySetInnerHTML !== null && n.dangerouslySetInnerHTML.__html != null
}
var Xi = typeof setTimeout == "function" ? setTimeout : void 0,
    l1 = typeof clearTimeout == "function" ? clearTimeout : void 0,
    qu = typeof Promise == "function" ? Promise : void 0,
    i1 = typeof queueMicrotask == "function" ? queueMicrotask : typeof qu < "u" ? function(e) {
        return qu.resolve(null).then(e).catch(o1)
    } : Xi;

function o1(e) {
    setTimeout(function() {
        throw e
    })
}

function ai(e, n) {
    var t = n,
        r = 0;
    do {
        var l = t.nextSibling;
        if (e.removeChild(t), l && l.nodeType === 8)
            if (t = l.data, t === "/$") {
                if (r === 0) {
                    e.removeChild(l), bt(n);
                    return
                }
                r--
            } else t !== "$" && t !== "$?" && t !== "$!" || r++;
        t = l
    } while (t);
    bt(n)
}

function pn(e) {
    for (; e != null; e = e.nextSibling) {
        var n = e.nodeType;
        if (n === 1 || n === 3) break;
        if (n === 8) {
            if (n = e.data, n === "$" || n === "$!" || n === "$?") break;
            if (n === "/$") return null
        }
    }
    return e
}

function bu(e) {
    e = e.previousSibling;
    for (var n = 0; e;) {
        if (e.nodeType === 8) {
            var t = e.data;
            if (t === "$" || t === "$!" || t === "$?") {
                if (n === 0) return e;
                n--
            } else t === "/$" && n++
        }
        e = e.previousSibling
    }
    return null
}
var kt = Math.random().toString(36).slice(2),
    $e = "__reactFiber$" + kt,
    lr = "__reactProps$" + kt,
    Je = "__reactContainer$" + kt,
    Yi = "__reactEvents$" + kt,
    u1 = "__reactListeners$" + kt,
    a1 = "__reactHandles$" + kt;

function Tn(e) {
    var n = e[$e];
    if (n) return n;
    for (var t = e.parentNode; t;) {
        if (n = t[Je] || t[$e]) {
            if (t = n.alternate, n.child !== null || t !== null && t.child !== null)
                for (e = bu(e); e !== null;) {
                    if (t = e[$e]) return t;
                    e = bu(e)
                }
            return n
        }
        e = t, t = e.parentNode
    }
    return null
}

function mr(e) {
    return e = e[$e] || e[Je], !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}

function qn(e) {
    if (e.tag === 5 || e.tag === 6) return e.stateNode;
    throw Error(k(33))
}

function Dl(e) {
    return e[lr] || null
}
var Ji = [],
    bn = -1;

function Cn(e) {
    return {
        current: e
    }
}

function B(e) {
    0 > bn || (e.current = Ji[bn], Ji[bn] = null, bn--)
}

function U(e, n) {
    bn++, Ji[bn] = e.current, e.current = n
}
var xn = {},
    ae = Cn(xn),
    he = Cn(!1),
    In = xn;

function pt(e, n) {
    var t = e.type.contextTypes;
    if (!t) return xn;
    var r = e.stateNode;
    if (r && r.__reactInternalMemoizedUnmaskedChildContext === n) return r.__reactInternalMemoizedMaskedChildContext;
    var l = {},
        i;
    for (i in t) l[i] = n[i];
    return r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = n, e.__reactInternalMemoizedMaskedChildContext = l), l
}

function ve(e) {
    return e = e.childContextTypes, e != null
}

function cl() {
    B(he), B(ae)
}

function ea(e, n, t) {
    if (ae.current !== xn) throw Error(k(168));
    U(ae, n), U(he, t)
}

function bs(e, n, t) {
    var r = e.stateNode;
    if (n = n.childContextTypes, typeof r.getChildContext != "function") return t;
    r = r.getChildContext();
    for (var l in r)
        if (!(l in n)) throw Error(k(108, Kf(e) || "Unknown", l));
    return Q({}, t, r)
}

function fl(e) {
    return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || xn, In = ae.current, U(ae, e), U(he, he.current), !0
}

function na(e, n, t) {
    var r = e.stateNode;
    if (!r) throw Error(k(169));
    t ? (e = bs(e, n, In), r.__reactInternalMemoizedMergedChildContext = e, B(he), B(ae), U(ae, e)) : B(he), U(he, t)
}
var Ke = null,
    zl = !1,
    si = !1;

function ec(e) {
    Ke === null ? Ke = [e] : Ke.push(e)
}

function s1(e) {
    zl = !0, ec(e)
}

function kn() {
    if (!si && Ke !== null) {
        si = !0;
        var e = 0,
            n = M;
        try {
            var t = Ke;
            for (M = 1; e < t.length; e++) {
                var r = t[e];
                do r = r(!0); while (r !== null)
            }
            Ke = null, zl = !1
        } catch (l) {
            throw Ke !== null && (Ke = Ke.slice(e + 1)), _s(Oo, kn), l
        } finally {
            M = n, si = !1
        }
    }
    return null
}
var et = [],
    nt = 0,
    dl = null,
    pl = 0,
    Ee = [],
    _e = 0,
    Mn = null,
    Ge = 1,
    Ze = "";

function _n(e, n) {
    et[nt++] = pl, et[nt++] = dl, dl = e, pl = n
}

function nc(e, n, t) {
    Ee[_e++] = Ge, Ee[_e++] = Ze, Ee[_e++] = Mn, Mn = e;
    var r = Ge;
    e = Ze;
    var l = 32 - Ie(r) - 1;
    r &= ~(1 << l), t += 1;
    var i = 32 - Ie(n) + l;
    if (30 < i) {
        var o = l - l % 5;
        i = (r & (1 << o) - 1).toString(32), r >>= o, l -= o, Ge = 1 << 32 - Ie(n) + l | t << l | r, Ze = i + e
    } else Ge = 1 << i | t << l | r, Ze = e
}

function Ho(e) {
    e.return !== null && (_n(e, 1), nc(e, 1, 0))
}

function Vo(e) {
    for (; e === dl;) dl = et[--nt], et[nt] = null, pl = et[--nt], et[nt] = null;
    for (; e === Mn;) Mn = Ee[--_e], Ee[_e] = null, Ze = Ee[--_e], Ee[_e] = null, Ge = Ee[--_e], Ee[_e] = null
}
var we = null,
    xe = null,
    H = !1,
    Re = null;

function tc(e, n) {
    var t = Ne(5, null, null, 0);
    t.elementType = "DELETED", t.stateNode = n, t.return = e, n = e.deletions, n === null ? (e.deletions = [t], e.flags |= 16) : n.push(t)
}

function ta(e, n) {
    switch (e.tag) {
        case 5:
            var t = e.type;
            return n = n.nodeType !== 1 || t.toLowerCase() !== n.nodeName.toLowerCase() ? null : n, n !== null ? (e.stateNode = n, we = e, xe = pn(n.firstChild), !0) : !1;
        case 6:
            return n = e.pendingProps === "" || n.nodeType !== 3 ? null : n, n !== null ? (e.stateNode = n, we = e, xe = null, !0) : !1;
        case 13:
            return n = n.nodeType !== 8 ? null : n, n !== null ? (t = Mn !== null ? {
                id: Ge,
                overflow: Ze
            } : null, e.memoizedState = {
                dehydrated: n,
                treeContext: t,
                retryLane: 1073741824
            }, t = Ne(18, null, null, 0), t.stateNode = n, t.return = e, e.child = t, we = e, xe = null, !0) : !1;
        default:
            return !1
    }
}

function qi(e) {
    return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}

function bi(e) {
    if (H) {
        var n = xe;
        if (n) {
            var t = n;
            if (!ta(e, n)) {
                if (qi(e)) throw Error(k(418));
                n = pn(t.nextSibling);
                var r = we;
                n && ta(e, n) ? tc(r, t) : (e.flags = e.flags & -4097 | 2, H = !1, we = e)
            }
        } else {
            if (qi(e)) throw Error(k(418));
            e.flags = e.flags & -4097 | 2, H = !1, we = e
        }
    }
}

function ra(e) {
    for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13;) e = e.return;
    we = e
}

function Dr(e) {
    if (e !== we) return !1;
    if (!H) return ra(e), H = !0, !1;
    var n;
    if ((n = e.tag !== 3) && !(n = e.tag !== 5) && (n = e.type, n = n !== "head" && n !== "body" && !Zi(e.type, e.memoizedProps)), n && (n = xe)) {
        if (qi(e)) throw rc(), Error(k(418));
        for (; n;) tc(e, n), n = pn(n.nextSibling)
    }
    if (ra(e), e.tag === 13) {
        if (e = e.memoizedState, e = e !== null ? e.dehydrated : null, !e) throw Error(k(317));
        e: {
            for (e = e.nextSibling, n = 0; e;) {
                if (e.nodeType === 8) {
                    var t = e.data;
                    if (t === "/$") {
                        if (n === 0) {
                            xe = pn(e.nextSibling);
                            break e
                        }
                        n--
                    } else t !== "$" && t !== "$!" && t !== "$?" || n++
                }
                e = e.nextSibling
            }
            xe = null
        }
    } else xe = we ? pn(e.stateNode.nextSibling) : null;
    return !0
}

function rc() {
    for (var e = xe; e;) e = pn(e.nextSibling)
}

function mt() {
    xe = we = null, H = !1
}

function Wo(e) {
    Re === null ? Re = [e] : Re.push(e)
}
var c1 = en.ReactCurrentBatchConfig;

function ze(e, n) {
    if (e && e.defaultProps) {
        n = Q({}, n), e = e.defaultProps;
        for (var t in e) n[t] === void 0 && (n[t] = e[t]);
        return n
    }
    return n
}
var ml = Cn(null),
    hl = null,
    tt = null,
    Qo = null;

function Ko() {
    Qo = tt = hl = null
}

function Go(e) {
    var n = ml.current;
    B(ml), e._currentValue = n
}

function eo(e, n, t) {
    for (; e !== null;) {
        var r = e.alternate;
        if ((e.childLanes & n) !== n ? (e.childLanes |= n, r !== null && (r.childLanes |= n)) : r !== null && (r.childLanes & n) !== n && (r.childLanes |= n), e === t) break;
        e = e.return
    }
}

function ct(e, n) {
    hl = e, Qo = tt = null, e = e.dependencies, e !== null && e.firstContext !== null && (e.lanes & n && (me = !0), e.firstContext = null)
}

function Le(e) {
    var n = e._currentValue;
    if (Qo !== e)
        if (e = {
            context: e,
            memoizedValue: n,
            next: null
        }, tt === null) {
            if (hl === null) throw Error(k(308));
            tt = e, hl.dependencies = {
                lanes: 0,
                firstContext: e
            }
        } else tt = tt.next = e;
    return n
}
var Pn = null;

function Zo(e) {
    Pn === null ? Pn = [e] : Pn.push(e)
}

function lc(e, n, t, r) {
    var l = n.interleaved;
    return l === null ? (t.next = t, Zo(n)) : (t.next = l.next, l.next = t), n.interleaved = t, qe(e, r)
}

function qe(e, n) {
    e.lanes |= n;
    var t = e.alternate;
    for (t !== null && (t.lanes |= n), t = e, e = e.return; e !== null;) e.childLanes |= n, t = e.alternate, t !== null && (t.childLanes |= n), t = e, e = e.return;
    return t.tag === 3 ? t.stateNode : null
}
var ln = !1;

function Xo(e) {
    e.updateQueue = {
        baseState: e.memoizedState,
        firstBaseUpdate: null,
        lastBaseUpdate: null,
        shared: {
            pending: null,
            interleaved: null,
            lanes: 0
        },
        effects: null
    }
}

function ic(e, n) {
    e = e.updateQueue, n.updateQueue === e && (n.updateQueue = {
        baseState: e.baseState,
        firstBaseUpdate: e.firstBaseUpdate,
        lastBaseUpdate: e.lastBaseUpdate,
        shared: e.shared,
        effects: e.effects
    })
}

function Xe(e, n) {
    return {
        eventTime: e,
        lane: n,
        tag: 0,
        payload: null,
        callback: null,
        next: null
    }
}

function mn(e, n, t) {
    var r = e.updateQueue;
    if (r === null) return null;
    if (r = r.shared, I & 2) {
        var l = r.pending;
        return l === null ? n.next = n : (n.next = l.next, l.next = n), r.pending = n, qe(e, t)
    }
    return l = r.interleaved, l === null ? (n.next = n, Zo(r)) : (n.next = l.next, l.next = n), r.interleaved = n, qe(e, t)
}

function Zr(e, n, t) {
    if (n = n.updateQueue, n !== null && (n = n.shared, (t & 4194240) !== 0)) {
        var r = n.lanes;
        r &= e.pendingLanes, t |= r, n.lanes = t, Ro(e, t)
    }
}

function la(e, n) {
    var t = e.updateQueue,
        r = e.alternate;
    if (r !== null && (r = r.updateQueue, t === r)) {
        var l = null,
            i = null;
        if (t = t.firstBaseUpdate, t !== null) {
            do {
                var o = {
                    eventTime: t.eventTime,
                    lane: t.lane,
                    tag: t.tag,
                    payload: t.payload,
                    callback: t.callback,
                    next: null
                };
                i === null ? l = i = o : i = i.next = o, t = t.next
            } while (t !== null);
            i === null ? l = i = n : i = i.next = n
        } else l = i = n;
        t = {
            baseState: r.baseState,
            firstBaseUpdate: l,
            lastBaseUpdate: i,
            shared: r.shared,
            effects: r.effects
        }, e.updateQueue = t;
        return
    }
    e = t.lastBaseUpdate, e === null ? t.firstBaseUpdate = n : e.next = n, t.lastBaseUpdate = n
}

function vl(e, n, t, r) {
    var l = e.updateQueue;
    ln = !1;
    var i = l.firstBaseUpdate,
        o = l.lastBaseUpdate,
        u = l.shared.pending;
    if (u !== null) {
        l.shared.pending = null;
        var a = u,
            s = a.next;
        a.next = null, o === null ? i = s : o.next = s, o = a;
        var m = e.alternate;
        m !== null && (m = m.updateQueue, u = m.lastBaseUpdate, u !== o && (u === null ? m.firstBaseUpdate = s : u.next = s, m.lastBaseUpdate = a))
    }
    if (i !== null) {
        var v = l.baseState;
        o = 0, m = s = a = null, u = i;
        do {
            var h = u.lane,
                C = u.eventTime;
            if ((r & h) === h) {
                m !== null && (m = m.next = {
                    eventTime: C,
                    lane: 0,
                    tag: u.tag,
                    payload: u.payload,
                    callback: u.callback,
                    next: null
                });
                e: {
                    var g = e,
                        x = u;
                    switch (h = n, C = t, x.tag) {
                        case 1:
                            if (g = x.payload, typeof g == "function") {
                                v = g.call(C, v, h);
                                break e
                            }
                            v = g;
                            break e;
                        case 3:
                            g.flags = g.flags & -65537 | 128;
                        case 0:
                            if (g = x.payload, h = typeof g == "function" ? g.call(C, v, h) : g, h == null) break e;
                            v = Q({}, v, h);
                            break e;
                        case 2:
                            ln = !0
                    }
                }
                u.callback !== null && u.lane !== 0 && (e.flags |= 64, h = l.effects, h === null ? l.effects = [u] : h.push(u))
            } else C = {
                eventTime: C,
                lane: h,
                tag: u.tag,
                payload: u.payload,
                callback: u.callback,
                next: null
            }, m === null ? (s = m = C, a = v) : m = m.next = C, o |= h;
            if (u = u.next, u === null) {
                if (u = l.shared.pending, u === null) break;
                h = u, u = h.next, h.next = null, l.lastBaseUpdate = h, l.shared.pending = null
            }
        } while (1);
        if (m === null && (a = v), l.baseState = a, l.firstBaseUpdate = s, l.lastBaseUpdate = m, n = l.shared.interleaved, n !== null) {
            l = n;
            do o |= l.lane, l = l.next; while (l !== n)
        } else i === null && (l.shared.lanes = 0);
        An |= o, e.lanes = o, e.memoizedState = v
    }
}

function ia(e, n, t) {
    if (e = n.effects, n.effects = null, e !== null)
        for (n = 0; n < e.length; n++) {
            var r = e[n],
                l = r.callback;
            if (l !== null) {
                if (r.callback = null, r = t, typeof l != "function") throw Error(k(191, l));
                l.call(r)
            }
        }
}
var oc = new ls.Component().refs;

function no(e, n, t, r) {
    n = e.memoizedState, t = t(r, n), t = t == null ? n : Q({}, n, t), e.memoizedState = t, e.lanes === 0 && (e.updateQueue.baseState = t)
}
var Ol = {
    isMounted: function(e) {
        return (e = e._reactInternals) ? Bn(e) === e : !1
    },
    enqueueSetState: function(e, n, t) {
        e = e._reactInternals;
        var r = ce(),
            l = vn(e),
            i = Xe(r, l);
        i.payload = n, t != null && (i.callback = t), n = mn(e, i, l), n !== null && (Me(n, e, l, r), Zr(n, e, l))
    },
    enqueueReplaceState: function(e, n, t) {
        e = e._reactInternals;
        var r = ce(),
            l = vn(e),
            i = Xe(r, l);
        i.tag = 1, i.payload = n, t != null && (i.callback = t), n = mn(e, i, l), n !== null && (Me(n, e, l, r), Zr(n, e, l))
    },
    enqueueForceUpdate: function(e, n) {
        e = e._reactInternals;
        var t = ce(),
            r = vn(e),
            l = Xe(t, r);
        l.tag = 2, n != null && (l.callback = n), n = mn(e, l, r), n !== null && (Me(n, e, r, t), Zr(n, e, r))
    }
};

function oa(e, n, t, r, l, i, o) {
    return e = e.stateNode, typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, i, o) : n.prototype && n.prototype.isPureReactComponent ? !nr(t, r) || !nr(l, i) : !0
}

function uc(e, n, t) {
    var r = !1,
        l = xn,
        i = n.contextType;
    return typeof i == "object" && i !== null ? i = Le(i) : (l = ve(n) ? In : ae.current, r = n.contextTypes, i = (r = r != null) ? pt(e, l) : xn), n = new n(t, i), e.memoizedState = n.state !== null && n.state !== void 0 ? n.state : null, n.updater = Ol, e.stateNode = n, n._reactInternals = e, r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = l, e.__reactInternalMemoizedMaskedChildContext = i), n
}

function ua(e, n, t, r) {
    e = n.state, typeof n.componentWillReceiveProps == "function" && n.componentWillReceiveProps(t, r), typeof n.UNSAFE_componentWillReceiveProps == "function" && n.UNSAFE_componentWillReceiveProps(t, r), n.state !== e && Ol.enqueueReplaceState(n, n.state, null)
}

function to(e, n, t, r) {
    var l = e.stateNode;
    l.props = t, l.state = e.memoizedState, l.refs = oc, Xo(e);
    var i = n.contextType;
    typeof i == "object" && i !== null ? l.context = Le(i) : (i = ve(n) ? In : ae.current, l.context = pt(e, i)), l.state = e.memoizedState, i = n.getDerivedStateFromProps, typeof i == "function" && (no(e, n, i, t), l.state = e.memoizedState), typeof n.getDerivedStateFromProps == "function" || typeof l.getSnapshotBeforeUpdate == "function" || typeof l.UNSAFE_componentWillMount != "function" && typeof l.componentWillMount != "function" || (n = l.state, typeof l.componentWillMount == "function" && l.componentWillMount(), typeof l.UNSAFE_componentWillMount == "function" && l.UNSAFE_componentWillMount(), n !== l.state && Ol.enqueueReplaceState(l, l.state, null), vl(e, t, l, r), l.state = e.memoizedState), typeof l.componentDidMount == "function" && (e.flags |= 4194308)
}

function Lt(e, n, t) {
    if (e = t.ref, e !== null && typeof e != "function" && typeof e != "object") {
        if (t._owner) {
            if (t = t._owner, t) {
                if (t.tag !== 1) throw Error(k(309));
                var r = t.stateNode
            }
            if (!r) throw Error(k(147, e));
            var l = r,
                i = "" + e;
            return n !== null && n.ref !== null && typeof n.ref == "function" && n.ref._stringRef === i ? n.ref : (n = function(o) {
                var u = l.refs;
                u === oc && (u = l.refs = {}), o === null ? delete u[i] : u[i] = o
            }, n._stringRef = i, n)
        }
        if (typeof e != "string") throw Error(k(284));
        if (!t._owner) throw Error(k(290, e))
    }
    return e
}

function zr(e, n) {
    throw e = Object.prototype.toString.call(n), Error(k(31, e === "[object Object]" ? "object with keys {" + Object.keys(n).join(", ") + "}" : e))
}

function aa(e) {
    var n = e._init;
    return n(e._payload)
}

function ac(e) {
    function n(f, c) {
        if (e) {
            var d = f.deletions;
            d === null ? (f.deletions = [c], f.flags |= 16) : d.push(c)
        }
    }

    function t(f, c) {
        if (!e) return null;
        for (; c !== null;) n(f, c), c = c.sibling;
        return null
    }

    function r(f, c) {
        for (f = new Map; c !== null;) c.key !== null ? f.set(c.key, c) : f.set(c.index, c), c = c.sibling;
        return f
    }

    function l(f, c) {
        return f = gn(f, c), f.index = 0, f.sibling = null, f
    }

    function i(f, c, d) {
        return f.index = d, e ? (d = f.alternate, d !== null ? (d = d.index, d < c ? (f.flags |= 2, c) : d) : (f.flags |= 2, c)) : (f.flags |= 1048576, c)
    }

    function o(f) {
        return e && f.alternate === null && (f.flags |= 2), f
    }

    function u(f, c, d, y) {
        return c === null || c.tag !== 6 ? (c = vi(d, f.mode, y), c.return = f, c) : (c = l(c, d), c.return = f, c)
    }

    function a(f, c, d, y) {
        var S = d.type;
        return S === Zn ? m(f, c, d.props.children, y, d.key) : c !== null && (c.elementType === S || typeof S == "object" && S !== null && S.$$typeof === rn && aa(S) === c.type) ? (y = l(c, d.props), y.ref = Lt(f, c, d), y.return = f, y) : (y = el(d.type, d.key, d.props, null, f.mode, y), y.ref = Lt(f, c, d), y.return = f, y)
    }

    function s(f, c, d, y) {
        return c === null || c.tag !== 4 || c.stateNode.containerInfo !== d.containerInfo || c.stateNode.implementation !== d.implementation ? (c = gi(d, f.mode, y), c.return = f, c) : (c = l(c, d.children || []), c.return = f, c)
    }

    function m(f, c, d, y, S) {
        return c === null || c.tag !== 7 ? (c = On(d, f.mode, y, S), c.return = f, c) : (c = l(c, d), c.return = f, c)
    }

    function v(f, c, d) {
        if (typeof c == "string" && c !== "" || typeof c == "number") return c = vi("" + c, f.mode, d), c.return = f, c;
        if (typeof c == "object" && c !== null) {
            switch (c.$$typeof) {
                case Cr:
                    return d = el(c.type, c.key, c.props, null, f.mode, d), d.ref = Lt(f, null, c), d.return = f, d;
                case Gn:
                    return c = gi(c, f.mode, d), c.return = f, c;
                case rn:
                    var y = c._init;
                    return v(f, y(c._payload), d)
            }
            if (It(c) || St(c)) return c = On(c, f.mode, d, null), c.return = f, c;
            zr(f, c)
        }
        return null
    }

    function h(f, c, d, y) {
        var S = c !== null ? c.key : null;
        if (typeof d == "string" && d !== "" || typeof d == "number") return S !== null ? null : u(f, c, "" + d, y);
        if (typeof d == "object" && d !== null) {
            switch (d.$$typeof) {
                case Cr:
                    return d.key === S ? a(f, c, d, y) : null;
                case Gn:
                    return d.key === S ? s(f, c, d, y) : null;
                case rn:
                    return S = d._init, h(f, c, S(d._payload), y)
            }
            if (It(d) || St(d)) return S !== null ? null : m(f, c, d, y, null);
            zr(f, d)
        }
        return null
    }

    function C(f, c, d, y, S) {
        if (typeof y == "string" && y !== "" || typeof y == "number") return f = f.get(d) || null, u(c, f, "" + y, S);
        if (typeof y == "object" && y !== null) {
            switch (y.$$typeof) {
                case Cr:
                    return f = f.get(y.key === null ? d : y.key) || null, a(c, f, y, S);
                case Gn:
                    return f = f.get(y.key === null ? d : y.key) || null, s(c, f, y, S);
                case rn:
                    var E = y._init;
                    return C(f, c, d, E(y._payload), S)
            }
            if (It(y) || St(y)) return f = f.get(d) || null, m(c, f, y, S, null);
            zr(c, y)
        }
        return null
    }

    function g(f, c, d, y) {
        for (var S = null, E = null, w = c, _ = c = 0, R = null; w !== null && _ < d.length; _++) {
            w.index > _ ? (R = w, w = null) : R = w.sibling;
            var P = h(f, w, d[_], y);
            if (P === null) {
                w === null && (w = R);
                break
            }
            e && w && P.alternate === null && n(f, w), c = i(P, c, _), E === null ? S = P : E.sibling = P, E = P, w = R
        }
        if (_ === d.length) return t(f, w), H && _n(f, _), S;
        if (w === null) {
            for (; _ < d.length; _++) w = v(f, d[_], y), w !== null && (c = i(w, c, _), E === null ? S = w : E.sibling = w, E = w);
            return H && _n(f, _), S
        }
        for (w = r(f, w); _ < d.length; _++) R = C(w, f, _, d[_], y), R !== null && (e && R.alternate !== null && w.delete(R.key === null ? _ : R.key), c = i(R, c, _), E === null ? S = R : E.sibling = R, E = R);
        return e && w.forEach(function(q) {
            return n(f, q)
        }), H && _n(f, _), S
    }

    function x(f, c, d, y) {
        var S = St(d);
        if (typeof S != "function") throw Error(k(150));
        if (d = S.call(d), d == null) throw Error(k(151));
        for (var E = S = null, w = c, _ = c = 0, R = null, P = d.next(); w !== null && !P.done; _++, P = d.next()) {
            w.index > _ ? (R = w, w = null) : R = w.sibling;
            var q = h(f, w, P.value, y);
            if (q === null) {
                w === null && (w = R);
                break
            }
            e && w && q.alternate === null && n(f, w), c = i(q, c, _), E === null ? S = q : E.sibling = q, E = q, w = R
        }
        if (P.done) return t(f, w), H && _n(f, _), S;
        if (w === null) {
            for (; !P.done; _++, P = d.next()) P = v(f, P.value, y), P !== null && (c = i(P, c, _), E === null ? S = P : E.sibling = P, E = P);
            return H && _n(f, _), S
        }
        for (w = r(f, w); !P.done; _++, P = d.next()) P = C(w, f, _, P.value, y), P !== null && (e && P.alternate !== null && w.delete(P.key === null ? _ : P.key), c = i(P, c, _), E === null ? S = P : E.sibling = P, E = P);
        return e && w.forEach(function(nn) {
            return n(f, nn)
        }), H && _n(f, _), S
    }

    function L(f, c, d, y) {
        if (typeof d == "object" && d !== null && d.type === Zn && d.key === null && (d = d.props.children), typeof d == "object" && d !== null) {
            switch (d.$$typeof) {
                case Cr:
                    e: {
                        for (var S = d.key, E = c; E !== null;) {
                            if (E.key === S) {
                                if (S = d.type, S === Zn) {
                                    if (E.tag === 7) {
                                        t(f, E.sibling), c = l(E, d.props.children), c.return = f, f = c;
                                        break e
                                    }
                                } else if (E.elementType === S || typeof S == "object" && S !== null && S.$$typeof === rn && aa(S) === E.type) {
                                    t(f, E.sibling), c = l(E, d.props), c.ref = Lt(f, E, d), c.return = f, f = c;
                                    break e
                                }
                                t(f, E);
                                break
                            } else n(f, E);
                            E = E.sibling
                        }
                        d.type === Zn ? (c = On(d.props.children, f.mode, y, d.key), c.return = f, f = c) : (y = el(d.type, d.key, d.props, null, f.mode, y), y.ref = Lt(f, c, d), y.return = f, f = y)
                    }
                    return o(f);
                case Gn:
                    e: {
                        for (E = d.key; c !== null;) {
                            if (c.key === E)
                                if (c.tag === 4 && c.stateNode.containerInfo === d.containerInfo && c.stateNode.implementation === d.implementation) {
                                    t(f, c.sibling), c = l(c, d.children || []), c.return = f, f = c;
                                    break e
                                } else {
                                    t(f, c);
                                    break
                                }
                            else n(f, c);
                            c = c.sibling
                        }
                        c = gi(d, f.mode, y),
                            c.return = f,
                            f = c
                    }
                    return o(f);
                case rn:
                    return E = d._init, L(f, c, E(d._payload), y)
            }
            if (It(d)) return g(f, c, d, y);
            if (St(d)) return x(f, c, d, y);
            zr(f, d)
        }
        return typeof d == "string" && d !== "" || typeof d == "number" ? (d = "" + d, c !== null && c.tag === 6 ? (t(f, c.sibling), c = l(c, d), c.return = f, f = c) : (t(f, c), c = vi(d, f.mode, y), c.return = f, f = c), o(f)) : t(f, c)
    }
    return L
}
var ht = ac(!0),
    sc = ac(!1),
    hr = {},
    He = Cn(hr),
    ir = Cn(hr),
    or = Cn(hr);

function Dn(e) {
    if (e === hr) throw Error(k(174));
    return e
}

function Yo(e, n) {
    switch (U(or, n), U(ir, e), U(He, hr), e = n.nodeType, e) {
        case 9:
        case 11:
            n = (n = n.documentElement) ? n.namespaceURI : Ri(null, "");
            break;
        default:
            e = e === 8 ? n.parentNode : n, n = e.namespaceURI || null, e = e.tagName, n = Ri(n, e)
    }
    B(He), U(He, n)
}

function vt() {
    B(He), B(ir), B(or)
}

function cc(e) {
    Dn(or.current);
    var n = Dn(He.current),
        t = Ri(n, e.type);
    n !== t && (U(ir, e), U(He, t))
}

function Jo(e) {
    ir.current === e && (B(He), B(ir))
}
var V = Cn(0);

function gl(e) {
    for (var n = e; n !== null;) {
        if (n.tag === 13) {
            var t = n.memoizedState;
            if (t !== null && (t = t.dehydrated, t === null || t.data === "$?" || t.data === "$!")) return n
        } else if (n.tag === 19 && n.memoizedProps.revealOrder !== void 0) {
            if (n.flags & 128) return n
        } else if (n.child !== null) {
            n.child.return = n, n = n.child;
            continue
        }
        if (n === e) break;
        for (; n.sibling === null;) {
            if (n.return === null || n.return === e) return null;
            n = n.return
        }
        n.sibling.return = n.return, n = n.sibling
    }
    return null
}
var ci = [];

function qo() {
    for (var e = 0; e < ci.length; e++) ci[e]._workInProgressVersionPrimary = null;
    ci.length = 0
}
var Xr = en.ReactCurrentDispatcher,
    fi = en.ReactCurrentBatchConfig,
    Fn = 0,
    W = null,
    Y = null,
    ee = null,
    yl = !1,
    Vt = !1,
    ur = 0,
    f1 = 0;

function ie() {
    throw Error(k(321))
}

function bo(e, n) {
    if (n === null) return !1;
    for (var t = 0; t < n.length && t < e.length; t++)
        if (!Fe(e[t], n[t])) return !1;
    return !0
}

function eu(e, n, t, r, l, i) {
    if (Fn = i, W = n, n.memoizedState = null, n.updateQueue = null, n.lanes = 0, Xr.current = e === null || e.memoizedState === null ? h1 : v1, e = t(r, l), Vt) {
        i = 0;
        do {
            if (Vt = !1, ur = 0, 25 <= i) throw Error(k(301));
            i += 1, ee = Y = null, n.updateQueue = null, Xr.current = g1, e = t(r, l)
        } while (Vt)
    }
    if (Xr.current = xl, n = Y !== null && Y.next !== null, Fn = 0, ee = Y = W = null, yl = !1, n) throw Error(k(300));
    return e
}

function nu() {
    var e = ur !== 0;
    return ur = 0, e
}

function Ue() {
    var e = {
        memoizedState: null,
        baseState: null,
        baseQueue: null,
        queue: null,
        next: null
    };
    return ee === null ? W.memoizedState = ee = e : ee = ee.next = e, ee
}

function Te() {
    if (Y === null) {
        var e = W.alternate;
        e = e !== null ? e.memoizedState : null
    } else e = Y.next;
    var n = ee === null ? W.memoizedState : ee.next;
    if (n !== null) ee = n, Y = e;
    else {
        if (e === null) throw Error(k(310));
        Y = e, e = {
            memoizedState: Y.memoizedState,
            baseState: Y.baseState,
            baseQueue: Y.baseQueue,
            queue: Y.queue,
            next: null
        }, ee === null ? W.memoizedState = ee = e : ee = ee.next = e
    }
    return ee
}

function ar(e, n) {
    return typeof n == "function" ? n(e) : n
}

function di(e) {
    var n = Te(),
        t = n.queue;
    if (t === null) throw Error(k(311));
    t.lastRenderedReducer = e;
    var r = Y,
        l = r.baseQueue,
        i = t.pending;
    if (i !== null) {
        if (l !== null) {
            var o = l.next;
            l.next = i.next, i.next = o
        }
        r.baseQueue = l = i, t.pending = null
    }
    if (l !== null) {
        i = l.next, r = r.baseState;
        var u = o = null,
            a = null,
            s = i;
        do {
            var m = s.lane;
            if ((Fn & m) === m) a !== null && (a = a.next = {
                lane: 0,
                action: s.action,
                hasEagerState: s.hasEagerState,
                eagerState: s.eagerState,
                next: null
            }), r = s.hasEagerState ? s.eagerState : e(r, s.action);
            else {
                var v = {
                    lane: m,
                    action: s.action,
                    hasEagerState: s.hasEagerState,
                    eagerState: s.eagerState,
                    next: null
                };
                a === null ? (u = a = v, o = r) : a = a.next = v, W.lanes |= m, An |= m
            }
            s = s.next
        } while (s !== null && s !== i);
        a === null ? o = r : a.next = u, Fe(r, n.memoizedState) || (me = !0), n.memoizedState = r, n.baseState = o, n.baseQueue = a, t.lastRenderedState = r
    }
    if (e = t.interleaved, e !== null) {
        l = e;
        do i = l.lane, W.lanes |= i, An |= i, l = l.next; while (l !== e)
    } else l === null && (t.lanes = 0);
    return [n.memoizedState, t.dispatch]
}

function pi(e) {
    var n = Te(),
        t = n.queue;
    if (t === null) throw Error(k(311));
    t.lastRenderedReducer = e;
    var r = t.dispatch,
        l = t.pending,
        i = n.memoizedState;
    if (l !== null) {
        t.pending = null;
        var o = l = l.next;
        do i = e(i, o.action), o = o.next; while (o !== l);
        Fe(i, n.memoizedState) || (me = !0), n.memoizedState = i, n.baseQueue === null && (n.baseState = i), t.lastRenderedState = i
    }
    return [i, r]
}

function fc() {}

function dc(e, n) {
    var t = W,
        r = Te(),
        l = n(),
        i = !Fe(r.memoizedState, l);
    if (i && (r.memoizedState = l, me = !0), r = r.queue, tu(hc.bind(null, t, r, e), [e]), r.getSnapshot !== n || i || ee !== null && ee.memoizedState.tag & 1) {
        if (t.flags |= 2048, sr(9, mc.bind(null, t, r, l, n), void 0, null), ne === null) throw Error(k(349));
        Fn & 30 || pc(t, n, l)
    }
    return l
}

function pc(e, n, t) {
    e.flags |= 16384, e = {
        getSnapshot: n,
        value: t
    }, n = W.updateQueue, n === null ? (n = {
        lastEffect: null,
        stores: null
    }, W.updateQueue = n, n.stores = [e]) : (t = n.stores, t === null ? n.stores = [e] : t.push(e))
}

function mc(e, n, t, r) {
    n.value = t, n.getSnapshot = r, vc(n) && gc(e)
}

function hc(e, n, t) {
    return t(function() {
        vc(n) && gc(e)
    })
}

function vc(e) {
    var n = e.getSnapshot;
    e = e.value;
    try {
        var t = n();
        return !Fe(e, t)
    } catch {
        return !0
    }
}

function gc(e) {
    var n = qe(e, 1);
    n !== null && Me(n, e, 1, -1)
}

function sa(e) {
    var n = Ue();
    return typeof e == "function" && (e = e()), n.memoizedState = n.baseState = e, e = {
        pending: null,
        interleaved: null,
        lanes: 0,
        dispatch: null,
        lastRenderedReducer: ar,
        lastRenderedState: e
    }, n.queue = e, e = e.dispatch = m1.bind(null, W, e), [n.memoizedState, e]
}

function sr(e, n, t, r) {
    return e = {
        tag: e,
        create: n,
        destroy: t,
        deps: r,
        next: null
    }, n = W.updateQueue, n === null ? (n = {
        lastEffect: null,
        stores: null
    }, W.updateQueue = n, n.lastEffect = e.next = e) : (t = n.lastEffect, t === null ? n.lastEffect = e.next = e : (r = t.next, t.next = e, e.next = r, n.lastEffect = e)), e
}

function yc() {
    return Te().memoizedState
}

function Yr(e, n, t, r) {
    var l = Ue();
    W.flags |= e, l.memoizedState = sr(1 | n, t, void 0, r === void 0 ? null : r)
}

function Rl(e, n, t, r) {
    var l = Te();
    r = r === void 0 ? null : r;
    var i = void 0;
    if (Y !== null) {
        var o = Y.memoizedState;
        if (i = o.destroy, r !== null && bo(r, o.deps)) {
            l.memoizedState = sr(n, t, i, r);
            return
        }
    }
    W.flags |= e, l.memoizedState = sr(1 | n, t, i, r)
}

function ca(e, n) {
    return Yr(8390656, 8, e, n)
}

function tu(e, n) {
    return Rl(2048, 8, e, n)
}

function xc(e, n) {
    return Rl(4, 2, e, n)
}

function wc(e, n) {
    return Rl(4, 4, e, n)
}

function Cc(e, n) {
    if (typeof n == "function") return e = e(), n(e),
        function() {
            n(null)
        };
    if (n != null) return e = e(), n.current = e,
        function() {
            n.current = null
        }
}

function kc(e, n, t) {
    return t = t != null ? t.concat([e]) : null, Rl(4, 4, Cc.bind(null, n, e), t)
}

function ru() {}

function Sc(e, n) {
    var t = Te();
    n = n === void 0 ? null : n;
    var r = t.memoizedState;
    return r !== null && n !== null && bo(n, r[1]) ? r[0] : (t.memoizedState = [e, n], e)
}

function Ec(e, n) {
    var t = Te();
    n = n === void 0 ? null : n;
    var r = t.memoizedState;
    return r !== null && n !== null && bo(n, r[1]) ? r[0] : (e = e(), t.memoizedState = [e, n], e)
}

function _c(e, n, t) {
    return Fn & 21 ? (Fe(t, n) || (t = Ls(), W.lanes |= t, An |= t, e.baseState = !0), n) : (e.baseState && (e.baseState = !1, me = !0), e.memoizedState = t)
}

function d1(e, n) {
    var t = M;
    M = t !== 0 && 4 > t ? t : 4, e(!0);
    var r = fi.transition;
    fi.transition = {};
    try {
        e(!1), n()
    } finally {
        M = t, fi.transition = r
    }
}

function Nc() {
    return Te().memoizedState
}

function p1(e, n, t) {
    var r = vn(e);
    if (t = {
        lane: r,
        action: t,
        hasEagerState: !1,
        eagerState: null,
        next: null
    }, jc(e)) Lc(n, t);
    else if (t = lc(e, n, t, r), t !== null) {
        var l = ce();
        Me(t, e, r, l), Tc(t, n, r)
    }
}

function m1(e, n, t) {
    var r = vn(e),
        l = {
            lane: r,
            action: t,
            hasEagerState: !1,
            eagerState: null,
            next: null
        };
    if (jc(e)) Lc(n, l);
    else {
        var i = e.alternate;
        if (e.lanes === 0 && (i === null || i.lanes === 0) && (i = n.lastRenderedReducer, i !== null)) try {
            var o = n.lastRenderedState,
                u = i(o, t);
            if (l.hasEagerState = !0, l.eagerState = u, Fe(u, o)) {
                var a = n.interleaved;
                a === null ? (l.next = l, Zo(n)) : (l.next = a.next, a.next = l), n.interleaved = l;
                return
            }
        } catch {} finally {}
        t = lc(e, n, l, r), t !== null && (l = ce(), Me(t, e, r, l), Tc(t, n, r))
    }
}

function jc(e) {
    var n = e.alternate;
    return e === W || n !== null && n === W
}

function Lc(e, n) {
    Vt = yl = !0;
    var t = e.pending;
    t === null ? n.next = n : (n.next = t.next, t.next = n), e.pending = n
}

function Tc(e, n, t) {
    if (t & 4194240) {
        var r = n.lanes;
        r &= e.pendingLanes, t |= r, n.lanes = t, Ro(e, t)
    }
}
var xl = {
        readContext: Le,
        useCallback: ie,
        useContext: ie,
        useEffect: ie,
        useImperativeHandle: ie,
        useInsertionEffect: ie,
        useLayoutEffect: ie,
        useMemo: ie,
        useReducer: ie,
        useRef: ie,
        useState: ie,
        useDebugValue: ie,
        useDeferredValue: ie,
        useTransition: ie,
        useMutableSource: ie,
        useSyncExternalStore: ie,
        useId: ie,
        unstable_isNewReconciler: !1
    },
    h1 = {
        readContext: Le,
        useCallback: function(e, n) {
            return Ue().memoizedState = [e, n === void 0 ? null : n], e
        },
        useContext: Le,
        useEffect: ca,
        useImperativeHandle: function(e, n, t) {
            return t = t != null ? t.concat([e]) : null, Yr(4194308, 4, Cc.bind(null, n, e), t)
        },
        useLayoutEffect: function(e, n) {
            return Yr(4194308, 4, e, n)
        },
        useInsertionEffect: function(e, n) {
            return Yr(4, 2, e, n)
        },
        useMemo: function(e, n) {
            var t = Ue();
            return n = n === void 0 ? null : n, e = e(), t.memoizedState = [e, n], e
        },
        useReducer: function(e, n, t) {
            var r = Ue();
            return n = t !== void 0 ? t(n) : n, r.memoizedState = r.baseState = n, e = {
                pending: null,
                interleaved: null,
                lanes: 0,
                dispatch: null,
                lastRenderedReducer: e,
                lastRenderedState: n
            }, r.queue = e, e = e.dispatch = p1.bind(null, W, e), [r.memoizedState, e]
        },
        useRef: function(e) {
            var n = Ue();
            return e = {
                current: e
            }, n.memoizedState = e
        },
        useState: sa,
        useDebugValue: ru,
        useDeferredValue: function(e) {
            return Ue().memoizedState = e
        },
        useTransition: function() {
            var e = sa(!1),
                n = e[0];
            return e = d1.bind(null, e[1]), Ue().memoizedState = e, [n, e]
        },
        useMutableSource: function() {},
        useSyncExternalStore: function(e, n, t) {
            var r = W,
                l = Ue();
            if (H) {
                if (t === void 0) throw Error(k(407));
                t = t()
            } else {
                if (t = n(), ne === null) throw Error(k(349));
                Fn & 30 || pc(r, n, t)
            }
            l.memoizedState = t;
            var i = {
                value: t,
                getSnapshot: n
            };
            return l.queue = i, ca(hc.bind(null, r, i, e), [e]), r.flags |= 2048, sr(9, mc.bind(null, r, i, t, n), void 0, null), t
        },
        useId: function() {
            var e = Ue(),
                n = ne.identifierPrefix;
            if (H) {
                var t = Ze,
                    r = Ge;
                t = (r & ~(1 << 32 - Ie(r) - 1)).toString(32) + t, n = ":" + n + "R" + t, t = ur++, 0 < t && (n += "H" + t.toString(32)), n += ":"
            } else t = f1++, n = ":" + n + "r" + t.toString(32) + ":";
            return e.memoizedState = n
        },
        unstable_isNewReconciler: !1
    },
    v1 = {
        readContext: Le,
        useCallback: Sc,
        useContext: Le,
        useEffect: tu,
        useImperativeHandle: kc,
        useInsertionEffect: xc,
        useLayoutEffect: wc,
        useMemo: Ec,
        useReducer: di,
        useRef: yc,
        useState: function() {
            return di(ar)
        },
        useDebugValue: ru,
        useDeferredValue: function(e) {
            var n = Te();
            return _c(n, Y.memoizedState, e)
        },
        useTransition: function() {
            var e = di(ar)[0],
                n = Te().memoizedState;
            return [e, n]
        },
        useMutableSource: fc,
        useSyncExternalStore: dc,
        useId: Nc,
        unstable_isNewReconciler: !1
    },
    g1 = {
        readContext: Le,
        useCallback: Sc,
        useContext: Le,
        useEffect: tu,
        useImperativeHandle: kc,
        useInsertionEffect: xc,
        useLayoutEffect: wc,
        useMemo: Ec,
        useReducer: pi,
        useRef: yc,
        useState: function() {
            return pi(ar)
        },
        useDebugValue: ru,
        useDeferredValue: function(e) {
            var n = Te();
            return Y === null ? n.memoizedState = e : _c(n, Y.memoizedState, e)
        },
        useTransition: function() {
            var e = pi(ar)[0],
                n = Te().memoizedState;
            return [e, n]
        },
        useMutableSource: fc,
        useSyncExternalStore: dc,
        useId: Nc,
        unstable_isNewReconciler: !1
    };

function gt(e, n) {
    try {
        var t = "",
            r = n;
        do t += Qf(r), r = r.return; while (r);
        var l = t
    } catch (i) {
        l = `
Error generating stack: ` + i.message + `
` + i.stack
    }
    return {
        value: e,
        source: n,
        stack: l,
        digest: null
    }
}

function mi(e, n, t) {
    return {
        value: e,
        source: null,
        stack: t ?? null,
        digest: n ?? null
    }
}

function ro(e, n) {
    try {
        console.error(n.value)
    } catch (t) {
        setTimeout(function() {
            throw t
        })
    }
}
var y1 = typeof WeakMap == "function" ? WeakMap : Map;

function Pc(e, n, t) {
    t = Xe(-1, t), t.tag = 3, t.payload = {
        element: null
    };
    var r = n.value;
    return t.callback = function() {
        Cl || (Cl = !0, mo = r), ro(e, n)
    }, t
}

function Dc(e, n, t) {
    t = Xe(-1, t), t.tag = 3;
    var r = e.type.getDerivedStateFromError;
    if (typeof r == "function") {
        var l = n.value;
        t.payload = function() {
            return r(l)
        }, t.callback = function() {
            ro(e, n)
        }
    }
    var i = e.stateNode;
    return i !== null && typeof i.componentDidCatch == "function" && (t.callback = function() {
        ro(e, n), typeof r != "function" && (hn === null ? hn = new Set([this]) : hn.add(this));
        var o = n.stack;
        this.componentDidCatch(n.value, {
            componentStack: o !== null ? o : ""
        })
    }), t
}

function fa(e, n, t) {
    var r = e.pingCache;
    if (r === null) {
        r = e.pingCache = new y1;
        var l = new Set;
        r.set(n, l)
    } else l = r.get(n), l === void 0 && (l = new Set, r.set(n, l));
    l.has(t) || (l.add(t), e = z1.bind(null, e, n, t), n.then(e, e))
}

function da(e) {
    do {
        var n;
        if ((n = e.tag === 13) && (n = e.memoizedState, n = n !== null ? n.dehydrated !== null : !0), n) return e;
        e = e.return
    } while (e !== null);
    return null
}

function pa(e, n, t, r, l) {
    return e.mode & 1 ? (e.flags |= 65536, e.lanes = l, e) : (e === n ? e.flags |= 65536 : (e.flags |= 128, t.flags |= 131072, t.flags &= -52805, t.tag === 1 && (t.alternate === null ? t.tag = 17 : (n = Xe(-1, 1), n.tag = 2, mn(t, n, 1))), t.lanes |= 1), e)
}
var x1 = en.ReactCurrentOwner,
    me = !1;

function se(e, n, t, r) {
    n.child = e === null ? sc(n, null, t, r) : ht(n, e.child, t, r)
}

function ma(e, n, t, r, l) {
    t = t.render;
    var i = n.ref;
    return ct(n, l), r = eu(e, n, t, r, i, l), t = nu(), e !== null && !me ? (n.updateQueue = e.updateQueue, n.flags &= -2053, e.lanes &= ~l, be(e, n, l)) : (H && t && Ho(n), n.flags |= 1, se(e, n, r, l), n.child)
}

function ha(e, n, t, r, l) {
    if (e === null) {
        var i = t.type;
        return typeof i == "function" && !fu(i) && i.defaultProps === void 0 && t.compare === null && t.defaultProps === void 0 ? (n.tag = 15, n.type = i, zc(e, n, i, r, l)) : (e = el(t.type, null, r, n, n.mode, l), e.ref = n.ref, e.return = n, n.child = e)
    }
    if (i = e.child, !(e.lanes & l)) {
        var o = i.memoizedProps;
        if (t = t.compare, t = t !== null ? t : nr, t(o, r) && e.ref === n.ref) return be(e, n, l)
    }
    return n.flags |= 1, e = gn(i, r), e.ref = n.ref, e.return = n, n.child = e
}

function zc(e, n, t, r, l) {
    if (e !== null) {
        var i = e.memoizedProps;
        if (nr(i, r) && e.ref === n.ref)
            if (me = !1, n.pendingProps = r = i, (e.lanes & l) !== 0) e.flags & 131072 && (me = !0);
            else return n.lanes = e.lanes, be(e, n, l)
    }
    return lo(e, n, t, r, l)
}

function Oc(e, n, t) {
    var r = n.pendingProps,
        l = r.children,
        i = e !== null ? e.memoizedState : null;
    if (r.mode === "hidden")
        if (!(n.mode & 1)) n.memoizedState = {
            baseLanes: 0,
            cachePool: null,
            transitions: null
        }, U(lt, ye), ye |= t;
        else {
            if (!(t & 1073741824)) return e = i !== null ? i.baseLanes | t : t, n.lanes = n.childLanes = 1073741824, n.memoizedState = {
                baseLanes: e,
                cachePool: null,
                transitions: null
            }, n.updateQueue = null, U(lt, ye), ye |= e, null;
            n.memoizedState = {
                baseLanes: 0,
                cachePool: null,
                transitions: null
            }, r = i !== null ? i.baseLanes : t, U(lt, ye), ye |= r
        }
    else i !== null ? (r = i.baseLanes | t, n.memoizedState = null) : r = t, U(lt, ye), ye |= r;
    return se(e, n, l, t), n.child
}

function Rc(e, n) {
    var t = n.ref;
    (e === null && t !== null || e !== null && e.ref !== t) && (n.flags |= 512, n.flags |= 2097152)
}

function lo(e, n, t, r, l) {
    var i = ve(t) ? In : ae.current;
    return i = pt(n, i), ct(n, l), t = eu(e, n, t, r, i, l), r = nu(), e !== null && !me ? (n.updateQueue = e.updateQueue, n.flags &= -2053, e.lanes &= ~l, be(e, n, l)) : (H && r && Ho(n), n.flags |= 1, se(e, n, t, l), n.child)
}

function va(e, n, t, r, l) {
    if (ve(t)) {
        var i = !0;
        fl(n)
    } else i = !1;
    if (ct(n, l), n.stateNode === null) Jr(e, n), uc(n, t, r), to(n, t, r, l), r = !0;
    else if (e === null) {
        var o = n.stateNode,
            u = n.memoizedProps;
        o.props = u;
        var a = o.context,
            s = t.contextType;
        typeof s == "object" && s !== null ? s = Le(s) : (s = ve(t) ? In : ae.current, s = pt(n, s));
        var m = t.getDerivedStateFromProps,
            v = typeof m == "function" || typeof o.getSnapshotBeforeUpdate == "function";
        v || typeof o.UNSAFE_componentWillReceiveProps != "function" && typeof o.componentWillReceiveProps != "function" || (u !== r || a !== s) && ua(n, o, r, s), ln = !1;
        var h = n.memoizedState;
        o.state = h, vl(n, r, o, l), a = n.memoizedState, u !== r || h !== a || he.current || ln ? (typeof m == "function" && (no(n, t, m, r), a = n.memoizedState), (u = ln || oa(n, t, u, r, h, a, s)) ? (v || typeof o.UNSAFE_componentWillMount != "function" && typeof o.componentWillMount != "function" || (typeof o.componentWillMount == "function" && o.componentWillMount(), typeof o.UNSAFE_componentWillMount == "function" && o.UNSAFE_componentWillMount()), typeof o.componentDidMount == "function" && (n.flags |= 4194308)) : (typeof o.componentDidMount == "function" && (n.flags |= 4194308), n.memoizedProps = r, n.memoizedState = a), o.props = r, o.state = a, o.context = s, r = u) : (typeof o.componentDidMount == "function" && (n.flags |= 4194308), r = !1)
    } else {
        o = n.stateNode, ic(e, n), u = n.memoizedProps, s = n.type === n.elementType ? u : ze(n.type, u), o.props = s, v = n.pendingProps, h = o.context, a = t.contextType, typeof a == "object" && a !== null ? a = Le(a) : (a = ve(t) ? In : ae.current, a = pt(n, a));
        var C = t.getDerivedStateFromProps;
        (m = typeof C == "function" || typeof o.getSnapshotBeforeUpdate == "function") || typeof o.UNSAFE_componentWillReceiveProps != "function" && typeof o.componentWillReceiveProps != "function" || (u !== v || h !== a) && ua(n, o, r, a), ln = !1, h = n.memoizedState, o.state = h, vl(n, r, o, l);
        var g = n.memoizedState;
        u !== v || h !== g || he.current || ln ? (typeof C == "function" && (no(n, t, C, r), g = n.memoizedState), (s = ln || oa(n, t, s, r, h, g, a) || !1) ? (m || typeof o.UNSAFE_componentWillUpdate != "function" && typeof o.componentWillUpdate != "function" || (typeof o.componentWillUpdate == "function" && o.componentWillUpdate(r, g, a), typeof o.UNSAFE_componentWillUpdate == "function" && o.UNSAFE_componentWillUpdate(r, g, a)), typeof o.componentDidUpdate == "function" && (n.flags |= 4), typeof o.getSnapshotBeforeUpdate == "function" && (n.flags |= 1024)) : (typeof o.componentDidUpdate != "function" || u === e.memoizedProps && h === e.memoizedState || (n.flags |= 4), typeof o.getSnapshotBeforeUpdate != "function" || u === e.memoizedProps && h === e.memoizedState || (n.flags |= 1024), n.memoizedProps = r, n.memoizedState = g), o.props = r, o.state = g, o.context = a, r = s) : (typeof o.componentDidUpdate != "function" || u === e.memoizedProps && h === e.memoizedState || (n.flags |= 4), typeof o.getSnapshotBeforeUpdate != "function" || u === e.memoizedProps && h === e.memoizedState || (n.flags |= 1024), r = !1)
    }
    return io(e, n, t, r, i, l)
}

function io(e, n, t, r, l, i) {
    Rc(e, n);
    var o = (n.flags & 128) !== 0;
    if (!r && !o) return l && na(n, t, !1), be(e, n, i);
    r = n.stateNode, x1.current = n;
    var u = o && typeof t.getDerivedStateFromError != "function" ? null : r.render();
    return n.flags |= 1, e !== null && o ? (n.child = ht(n, e.child, null, i), n.child = ht(n, null, u, i)) : se(e, n, u, i), n.memoizedState = r.state, l && na(n, t, !0), n.child
}

function Ic(e) {
    var n = e.stateNode;
    n.pendingContext ? ea(e, n.pendingContext, n.pendingContext !== n.context) : n.context && ea(e, n.context, !1), Yo(e, n.containerInfo)
}

function ga(e, n, t, r, l) {
    return mt(), Wo(l), n.flags |= 256, se(e, n, t, r), n.child
}
var oo = {
    dehydrated: null,
    treeContext: null,
    retryLane: 0
};

function uo(e) {
    return {
        baseLanes: e,
        cachePool: null,
        transitions: null
    }
}

function Mc(e, n, t) {
    var r = n.pendingProps,
        l = V.current,
        i = !1,
        o = (n.flags & 128) !== 0,
        u;
    if ((u = o) || (u = e !== null && e.memoizedState === null ? !1 : (l & 2) !== 0), u ? (i = !0, n.flags &= -129) : (e === null || e.memoizedState !== null) && (l |= 1), U(V, l & 1), e === null) return bi(n), e = n.memoizedState, e !== null && (e = e.dehydrated, e !== null) ? (n.mode & 1 ? e.data === "$!" ? n.lanes = 8 : n.lanes = 1073741824 : n.lanes = 1, null) : (o = r.children, e = r.fallback, i ? (r = n.mode, i = n.child, o = {
        mode: "hidden",
        children: o
    }, !(r & 1) && i !== null ? (i.childLanes = 0, i.pendingProps = o) : i = Fl(o, r, 0, null), e = On(e, r, t, null), i.return = n, e.return = n, i.sibling = e, n.child = i, n.child.memoizedState = uo(t), n.memoizedState = oo, e) : lu(n, o));
    if (l = e.memoizedState, l !== null && (u = l.dehydrated, u !== null)) return w1(e, n, o, r, u, l, t);
    if (i) {
        i = r.fallback, o = n.mode, l = e.child, u = l.sibling;
        var a = {
            mode: "hidden",
            children: r.children
        };
        return !(o & 1) && n.child !== l ? (r = n.child, r.childLanes = 0, r.pendingProps = a, n.deletions = null) : (r = gn(l, a), r.subtreeFlags = l.subtreeFlags & 14680064), u !== null ? i = gn(u, i) : (i = On(i, o, t, null), i.flags |= 2), i.return = n, r.return = n, r.sibling = i, n.child = r, r = i, i = n.child, o = e.child.memoizedState, o = o === null ? uo(t) : {
            baseLanes: o.baseLanes | t,
            cachePool: null,
            transitions: o.transitions
        }, i.memoizedState = o, i.childLanes = e.childLanes & ~t, n.memoizedState = oo, r
    }
    return i = e.child, e = i.sibling, r = gn(i, {
        mode: "visible",
        children: r.children
    }), !(n.mode & 1) && (r.lanes = t), r.return = n, r.sibling = null, e !== null && (t = n.deletions, t === null ? (n.deletions = [e], n.flags |= 16) : t.push(e)), n.child = r, n.memoizedState = null, r
}

function lu(e, n) {
    return n = Fl({
        mode: "visible",
        children: n
    }, e.mode, 0, null), n.return = e, e.child = n
}

function Or(e, n, t, r) {
    return r !== null && Wo(r), ht(n, e.child, null, t), e = lu(n, n.pendingProps.children), e.flags |= 2, n.memoizedState = null, e
}

function w1(e, n, t, r, l, i, o) {
    if (t) return n.flags & 256 ? (n.flags &= -257, r = mi(Error(k(422))), Or(e, n, o, r)) : n.memoizedState !== null ? (n.child = e.child, n.flags |= 128, null) : (i = r.fallback, l = n.mode, r = Fl({
        mode: "visible",
        children: r.children
    }, l, 0, null), i = On(i, l, o, null), i.flags |= 2, r.return = n, i.return = n, r.sibling = i, n.child = r, n.mode & 1 && ht(n, e.child, null, o), n.child.memoizedState = uo(o), n.memoizedState = oo, i);
    if (!(n.mode & 1)) return Or(e, n, o, null);
    if (l.data === "$!") {
        if (r = l.nextSibling && l.nextSibling.dataset, r) var u = r.dgst;
        return r = u, i = Error(k(419)), r = mi(i, r, void 0), Or(e, n, o, r)
    }
    if (u = (o & e.childLanes) !== 0, me || u) {
        if (r = ne, r !== null) {
            switch (o & -o) {
                case 4:
                    l = 2;
                    break;
                case 16:
                    l = 8;
                    break;
                case 64:
                case 128:
                case 256:
                case 512:
                case 1024:
                case 2048:
                case 4096:
                case 8192:
                case 16384:
                case 32768:
                case 65536:
                case 131072:
                case 262144:
                case 524288:
                case 1048576:
                case 2097152:
                case 4194304:
                case 8388608:
                case 16777216:
                case 33554432:
                case 67108864:
                    l = 32;
                    break;
                case 536870912:
                    l = 268435456;
                    break;
                default:
                    l = 0
            }
            l = l & (r.suspendedLanes | o) ? 0 : l, l !== 0 && l !== i.retryLane && (i.retryLane = l, qe(e, l), Me(r, e, l, -1))
        }
        return cu(), r = mi(Error(k(421))), Or(e, n, o, r)
    }
    return l.data === "$?" ? (n.flags |= 128, n.child = e.child, n = O1.bind(null, e), l._reactRetry = n, null) : (e = i.treeContext, xe = pn(l.nextSibling), we = n, H = !0, Re = null, e !== null && (Ee[_e++] = Ge, Ee[_e++] = Ze, Ee[_e++] = Mn, Ge = e.id, Ze = e.overflow, Mn = n), n = lu(n, r.children), n.flags |= 4096, n)
}

function ya(e, n, t) {
    e.lanes |= n;
    var r = e.alternate;
    r !== null && (r.lanes |= n), eo(e.return, n, t)
}

function hi(e, n, t, r, l) {
    var i = e.memoizedState;
    i === null ? e.memoizedState = {
        isBackwards: n,
        rendering: null,
        renderingStartTime: 0,
        last: r,
        tail: t,
        tailMode: l
    } : (i.isBackwards = n, i.rendering = null, i.renderingStartTime = 0, i.last = r, i.tail = t, i.tailMode = l)
}

function Fc(e, n, t) {
    var r = n.pendingProps,
        l = r.revealOrder,
        i = r.tail;
    if (se(e, n, r.children, t), r = V.current, r & 2) r = r & 1 | 2, n.flags |= 128;
    else {
        if (e !== null && e.flags & 128) e: for (e = n.child; e !== null;) {
            if (e.tag === 13) e.memoizedState !== null && ya(e, t, n);
            else if (e.tag === 19) ya(e, t, n);
            else if (e.child !== null) {
                e.child.return = e, e = e.child;
                continue
            }
            if (e === n) break e;
            for (; e.sibling === null;) {
                if (e.return === null || e.return === n) break e;
                e = e.return
            }
            e.sibling.return = e.return, e = e.sibling
        }
        r &= 1
    }
    if (U(V, r), !(n.mode & 1)) n.memoizedState = null;
    else switch (l) {
        case "forwards":
            for (t = n.child, l = null; t !== null;) e = t.alternate, e !== null && gl(e) === null && (l = t), t = t.sibling;
            t = l, t === null ? (l = n.child, n.child = null) : (l = t.sibling, t.sibling = null), hi(n, !1, l, t, i);
            break;
        case "backwards":
            for (t = null, l = n.child, n.child = null; l !== null;) {
                if (e = l.alternate, e !== null && gl(e) === null) {
                    n.child = l;
                    break
                }
                e = l.sibling, l.sibling = t, t = l, l = e
            }
            hi(n, !0, t, null, i);
            break;
        case "together":
            hi(n, !1, null, null, void 0);
            break;
        default:
            n.memoizedState = null
    }
    return n.child
}

function Jr(e, n) {
    !(n.mode & 1) && e !== null && (e.alternate = null, n.alternate = null, n.flags |= 2)
}

function be(e, n, t) {
    if (e !== null && (n.dependencies = e.dependencies), An |= n.lanes, !(t & n.childLanes)) return null;
    if (e !== null && n.child !== e.child) throw Error(k(153));
    if (n.child !== null) {
        for (e = n.child, t = gn(e, e.pendingProps), n.child = t, t.return = n; e.sibling !== null;) e = e.sibling, t = t.sibling = gn(e, e.pendingProps), t.return = n;
        t.sibling = null
    }
    return n.child
}

function C1(e, n, t) {
    switch (n.tag) {
        case 3:
            Ic(n), mt();
            break;
        case 5:
            cc(n);
            break;
        case 1:
            ve(n.type) && fl(n);
            break;
        case 4:
            Yo(n, n.stateNode.containerInfo);
            break;
        case 10:
            var r = n.type._context,
                l = n.memoizedProps.value;
            U(ml, r._currentValue), r._currentValue = l;
            break;
        case 13:
            if (r = n.memoizedState, r !== null) return r.dehydrated !== null ? (U(V, V.current & 1), n.flags |= 128, null) : t & n.child.childLanes ? Mc(e, n, t) : (U(V, V.current & 1), e = be(e, n, t), e !== null ? e.sibling : null);
            U(V, V.current & 1);
            break;
        case 19:
            if (r = (t & n.childLanes) !== 0, e.flags & 128) {
                if (r) return Fc(e, n, t);
                n.flags |= 128
            }
            if (l = n.memoizedState, l !== null && (l.rendering = null, l.tail = null, l.lastEffect = null), U(V, V.current), r) break;
            return null;
        case 22:
        case 23:
            return n.lanes = 0, Oc(e, n, t)
    }
    return be(e, n, t)
}
var Ac, ao, Uc, $c;
Ac = function(e, n) {
    for (var t = n.child; t !== null;) {
        if (t.tag === 5 || t.tag === 6) e.appendChild(t.stateNode);
        else if (t.tag !== 4 && t.child !== null) {
            t.child.return = t, t = t.child;
            continue
        }
        if (t === n) break;
        for (; t.sibling === null;) {
            if (t.return === null || t.return === n) return;
            t = t.return
        }
        t.sibling.return = t.return, t = t.sibling
    }
};
ao = function() {};
Uc = function(e, n, t, r) {
    var l = e.memoizedProps;
    if (l !== r) {
        e = n.stateNode, Dn(He.current);
        var i = null;
        switch (t) {
            case "input":
                l = Pi(e, l), r = Pi(e, r), i = [];
                break;
            case "select":
                l = Q({}, l, {
                    value: void 0
                }), r = Q({}, r, {
                    value: void 0
                }), i = [];
                break;
            case "textarea":
                l = Oi(e, l), r = Oi(e, r), i = [];
                break;
            default:
                typeof l.onClick != "function" && typeof r.onClick == "function" && (e.onclick = sl)
        }
        Ii(t, r);
        var o;
        t = null;
        for (s in l)
            if (!r.hasOwnProperty(s) && l.hasOwnProperty(s) && l[s] != null)
                if (s === "style") {
                    var u = l[s];
                    for (o in u) u.hasOwnProperty(o) && (t || (t = {}), t[o] = "")
                } else s !== "dangerouslySetInnerHTML" && s !== "children" && s !== "suppressContentEditableWarning" && s !== "suppressHydrationWarning" && s !== "autoFocus" && (Zt.hasOwnProperty(s) ? i || (i = []) : (i = i || []).push(s, null));
        for (s in r) {
            var a = r[s];
            if (u = l != null ? l[s] : void 0, r.hasOwnProperty(s) && a !== u && (a != null || u != null))
                if (s === "style")
                    if (u) {
                        for (o in u) !u.hasOwnProperty(o) || a && a.hasOwnProperty(o) || (t || (t = {}), t[o] = "");
                        for (o in a) a.hasOwnProperty(o) && u[o] !== a[o] && (t || (t = {}), t[o] = a[o])
                    } else t || (i || (i = []), i.push(s, t)), t = a;
                else s === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0, u = u ? u.__html : void 0, a != null && u !== a && (i = i || []).push(s, a)) : s === "children" ? typeof a != "string" && typeof a != "number" || (i = i || []).push(s, "" + a) : s !== "suppressContentEditableWarning" && s !== "suppressHydrationWarning" && (Zt.hasOwnProperty(s) ? (a != null && s === "onScroll" && $("scroll", e), i || u === a || (i = [])) : (i = i || []).push(s, a))
        }
        t && (i = i || []).push("style", t);
        var s = i;
        (n.updateQueue = s) && (n.flags |= 4)
    }
};
$c = function(e, n, t, r) {
    t !== r && (n.flags |= 4)
};

function Tt(e, n) {
    if (!H) switch (e.tailMode) {
        case "hidden":
            n = e.tail;
            for (var t = null; n !== null;) n.alternate !== null && (t = n), n = n.sibling;
            t === null ? e.tail = null : t.sibling = null;
            break;
        case "collapsed":
            t = e.tail;
            for (var r = null; t !== null;) t.alternate !== null && (r = t), t = t.sibling;
            r === null ? n || e.tail === null ? e.tail = null : e.tail.sibling = null : r.sibling = null
    }
}

function oe(e) {
    var n = e.alternate !== null && e.alternate.child === e.child,
        t = 0,
        r = 0;
    if (n)
        for (var l = e.child; l !== null;) t |= l.lanes | l.childLanes, r |= l.subtreeFlags & 14680064, r |= l.flags & 14680064, l.return = e, l = l.sibling;
    else
        for (l = e.child; l !== null;) t |= l.lanes | l.childLanes, r |= l.subtreeFlags, r |= l.flags, l.return = e, l = l.sibling;
    return e.subtreeFlags |= r, e.childLanes = t, n
}

function k1(e, n, t) {
    var r = n.pendingProps;
    switch (Vo(n), n.tag) {
        case 2:
        case 16:
        case 15:
        case 0:
        case 11:
        case 7:
        case 8:
        case 12:
        case 9:
        case 14:
            return oe(n), null;
        case 1:
            return ve(n.type) && cl(), oe(n), null;
        case 3:
            return r = n.stateNode, vt(), B(he), B(ae), qo(), r.pendingContext && (r.context = r.pendingContext, r.pendingContext = null), (e === null || e.child === null) && (Dr(n) ? n.flags |= 4 : e === null || e.memoizedState.isDehydrated && !(n.flags & 256) || (n.flags |= 1024, Re !== null && (go(Re), Re = null))), ao(e, n), oe(n), null;
        case 5:
            Jo(n);
            var l = Dn(or.current);
            if (t = n.type, e !== null && n.stateNode != null) Uc(e, n, t, r, l), e.ref !== n.ref && (n.flags |= 512, n.flags |= 2097152);
            else {
                if (!r) {
                    if (n.stateNode === null) throw Error(k(166));
                    return oe(n), null
                }
                if (e = Dn(He.current), Dr(n)) {
                    r = n.stateNode, t = n.type;
                    var i = n.memoizedProps;
                    switch (r[$e] = n, r[lr] = i, e = (n.mode & 1) !== 0, t) {
                        case "dialog":
                            $("cancel", r), $("close", r);
                            break;
                        case "iframe":
                        case "object":
                        case "embed":
                            $("load", r);
                            break;
                        case "video":
                        case "audio":
                            for (l = 0; l < Ft.length; l++) $(Ft[l], r);
                            break;
                        case "source":
                            $("error", r);
                            break;
                        case "img":
                        case "image":
                        case "link":
                            $("error", r), $("load", r);
                            break;
                        case "details":
                            $("toggle", r);
                            break;
                        case "input":
                            ju(r, i), $("invalid", r);
                            break;
                        case "select":
                            r._wrapperState = {
                                wasMultiple: !!i.multiple
                            }, $("invalid", r);
                            break;
                        case "textarea":
                            Tu(r, i), $("invalid", r)
                    }
                    Ii(t, i), l = null;
                    for (var o in i)
                        if (i.hasOwnProperty(o)) {
                            var u = i[o];
                            o === "children" ? typeof u == "string" ? r.textContent !== u && (i.suppressHydrationWarning !== !0 && Pr(r.textContent, u, e), l = ["children", u]) : typeof u == "number" && r.textContent !== "" + u && (i.suppressHydrationWarning !== !0 && Pr(r.textContent, u, e), l = ["children", "" + u]) : Zt.hasOwnProperty(o) && u != null && o === "onScroll" && $("scroll", r)
                        } switch (t) {
                        case "input":
                            kr(r), Lu(r, i, !0);
                            break;
                        case "textarea":
                            kr(r), Pu(r);
                            break;
                        case "select":
                        case "option":
                            break;
                        default:
                            typeof i.onClick == "function" && (r.onclick = sl)
                    }
                    r = l, n.updateQueue = r, r !== null && (n.flags |= 4)
                } else {
                    o = l.nodeType === 9 ? l : l.ownerDocument, e === "http://www.w3.org/1999/xhtml" && (e = ps(t)), e === "http://www.w3.org/1999/xhtml" ? t === "script" ? (e = o.createElement("div"), e.innerHTML = "<script><\/script>", e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = o.createElement(t, {
                        is: r.is
                    }) : (e = o.createElement(t), t === "select" && (o = e, r.multiple ? o.multiple = !0 : r.size && (o.size = r.size))) : e = o.createElementNS(e, t), e[$e] = n, e[lr] = r, Ac(e, n, !1, !1), n.stateNode = e;
                    e: {
                        switch (o = Mi(t, r), t) {
                            case "dialog":
                                $("cancel", e), $("close", e), l = r;
                                break;
                            case "iframe":
                            case "object":
                            case "embed":
                                $("load", e), l = r;
                                break;
                            case "video":
                            case "audio":
                                for (l = 0; l < Ft.length; l++) $(Ft[l], e);
                                l = r;
                                break;
                            case "source":
                                $("error", e), l = r;
                                break;
                            case "img":
                            case "image":
                            case "link":
                                $("error", e), $("load", e), l = r;
                                break;
                            case "details":
                                $("toggle", e), l = r;
                                break;
                            case "input":
                                ju(e, r), l = Pi(e, r), $("invalid", e);
                                break;
                            case "option":
                                l = r;
                                break;
                            case "select":
                                e._wrapperState = {
                                    wasMultiple: !!r.multiple
                                }, l = Q({}, r, {
                                    value: void 0
                                }), $("invalid", e);
                                break;
                            case "textarea":
                                Tu(e, r), l = Oi(e, r), $("invalid", e);
                                break;
                            default:
                                l = r
                        }
                        Ii(t, l),
                            u = l;
                        for (i in u)
                            if (u.hasOwnProperty(i)) {
                                var a = u[i];
                                i === "style" ? vs(e, a) : i === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0, a != null && ms(e, a)) : i === "children" ? typeof a == "string" ? (t !== "textarea" || a !== "") && Xt(e, a) : typeof a == "number" && Xt(e, "" + a) : i !== "suppressContentEditableWarning" && i !== "suppressHydrationWarning" && i !== "autoFocus" && (Zt.hasOwnProperty(i) ? a != null && i === "onScroll" && $("scroll", e) : a != null && Lo(e, i, a, o))
                            } switch (t) {
                            case "input":
                                kr(e), Lu(e, r, !1);
                                break;
                            case "textarea":
                                kr(e), Pu(e);
                                break;
                            case "option":
                                r.value != null && e.setAttribute("value", "" + yn(r.value));
                                break;
                            case "select":
                                e.multiple = !!r.multiple, i = r.value, i != null ? ot(e, !!r.multiple, i, !1) : r.defaultValue != null && ot(e, !!r.multiple, r.defaultValue, !0);
                                break;
                            default:
                                typeof l.onClick == "function" && (e.onclick = sl)
                        }
                        switch (t) {
                            case "button":
                            case "input":
                            case "select":
                            case "textarea":
                                r = !!r.autoFocus;
                                break e;
                            case "img":
                                r = !0;
                                break e;
                            default:
                                r = !1
                        }
                    }
                    r && (n.flags |= 4)
                }
                n.ref !== null && (n.flags |= 512, n.flags |= 2097152)
            }
            return oe(n), null;
        case 6:
            if (e && n.stateNode != null) $c(e, n, e.memoizedProps, r);
            else {
                if (typeof r != "string" && n.stateNode === null) throw Error(k(166));
                if (t = Dn(or.current), Dn(He.current), Dr(n)) {
                    if (r = n.stateNode, t = n.memoizedProps, r[$e] = n, (i = r.nodeValue !== t) && (e = we, e !== null)) switch (e.tag) {
                        case 3:
                            Pr(r.nodeValue, t, (e.mode & 1) !== 0);
                            break;
                        case 5:
                            e.memoizedProps.suppressHydrationWarning !== !0 && Pr(r.nodeValue, t, (e.mode & 1) !== 0)
                    }
                    i && (n.flags |= 4)
                } else r = (t.nodeType === 9 ? t : t.ownerDocument).createTextNode(r), r[$e] = n, n.stateNode = r
            }
            return oe(n), null;
        case 13:
            if (B(V), r = n.memoizedState, e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
                if (H && xe !== null && n.mode & 1 && !(n.flags & 128)) rc(), mt(), n.flags |= 98560, i = !1;
                else if (i = Dr(n), r !== null && r.dehydrated !== null) {
                    if (e === null) {
                        if (!i) throw Error(k(318));
                        if (i = n.memoizedState, i = i !== null ? i.dehydrated : null, !i) throw Error(k(317));
                        i[$e] = n
                    } else mt(), !(n.flags & 128) && (n.memoizedState = null), n.flags |= 4;
                    oe(n), i = !1
                } else Re !== null && (go(Re), Re = null), i = !0;
                if (!i) return n.flags & 65536 ? n : null
            }
            return n.flags & 128 ? (n.lanes = t, n) : (r = r !== null, r !== (e !== null && e.memoizedState !== null) && r && (n.child.flags |= 8192, n.mode & 1 && (e === null || V.current & 1 ? J === 0 && (J = 3) : cu())), n.updateQueue !== null && (n.flags |= 4), oe(n), null);
        case 4:
            return vt(), ao(e, n), e === null && tr(n.stateNode.containerInfo), oe(n), null;
        case 10:
            return Go(n.type._context), oe(n), null;
        case 17:
            return ve(n.type) && cl(), oe(n), null;
        case 19:
            if (B(V), i = n.memoizedState, i === null) return oe(n), null;
            if (r = (n.flags & 128) !== 0, o = i.rendering, o === null)
                if (r) Tt(i, !1);
                else {
                    if (J !== 0 || e !== null && e.flags & 128)
                        for (e = n.child; e !== null;) {
                            if (o = gl(e), o !== null) {
                                for (n.flags |= 128, Tt(i, !1), r = o.updateQueue, r !== null && (n.updateQueue = r, n.flags |= 4), n.subtreeFlags = 0, r = t, t = n.child; t !== null;) i = t, e = r, i.flags &= 14680066, o = i.alternate, o === null ? (i.childLanes = 0, i.lanes = e, i.child = null, i.subtreeFlags = 0, i.memoizedProps = null, i.memoizedState = null, i.updateQueue = null, i.dependencies = null, i.stateNode = null) : (i.childLanes = o.childLanes, i.lanes = o.lanes, i.child = o.child, i.subtreeFlags = 0, i.deletions = null, i.memoizedProps = o.memoizedProps, i.memoizedState = o.memoizedState, i.updateQueue = o.updateQueue, i.type = o.type, e = o.dependencies, i.dependencies = e === null ? null : {
                                    lanes: e.lanes,
                                    firstContext: e.firstContext
                                }), t = t.sibling;
                                return U(V, V.current & 1 | 2), n.child
                            }
                            e = e.sibling
                        }
                    i.tail !== null && Z() > yt && (n.flags |= 128, r = !0, Tt(i, !1), n.lanes = 4194304)
                }
            else {
                if (!r)
                    if (e = gl(o), e !== null) {
                        if (n.flags |= 128, r = !0, t = e.updateQueue, t !== null && (n.updateQueue = t, n.flags |= 4), Tt(i, !0), i.tail === null && i.tailMode === "hidden" && !o.alternate && !H) return oe(n), null
                    } else 2 * Z() - i.renderingStartTime > yt && t !== 1073741824 && (n.flags |= 128, r = !0, Tt(i, !1), n.lanes = 4194304);
                i.isBackwards ? (o.sibling = n.child, n.child = o) : (t = i.last, t !== null ? t.sibling = o : n.child = o, i.last = o)
            }
            return i.tail !== null ? (n = i.tail, i.rendering = n, i.tail = n.sibling, i.renderingStartTime = Z(), n.sibling = null, t = V.current, U(V, r ? t & 1 | 2 : t & 1), n) : (oe(n), null);
        case 22:
        case 23:
            return su(), r = n.memoizedState !== null, e !== null && e.memoizedState !== null !== r && (n.flags |= 8192), r && n.mode & 1 ? ye & 1073741824 && (oe(n), n.subtreeFlags & 6 && (n.flags |= 8192)) : oe(n), null;
        case 24:
            return null;
        case 25:
            return null
    }
    throw Error(k(156, n.tag))
}

function S1(e, n) {
    switch (Vo(n), n.tag) {
        case 1:
            return ve(n.type) && cl(), e = n.flags, e & 65536 ? (n.flags = e & -65537 | 128, n) : null;
        case 3:
            return vt(), B(he), B(ae), qo(), e = n.flags, e & 65536 && !(e & 128) ? (n.flags = e & -65537 | 128, n) : null;
        case 5:
            return Jo(n), null;
        case 13:
            if (B(V), e = n.memoizedState, e !== null && e.dehydrated !== null) {
                if (n.alternate === null) throw Error(k(340));
                mt()
            }
            return e = n.flags, e & 65536 ? (n.flags = e & -65537 | 128, n) : null;
        case 19:
            return B(V), null;
        case 4:
            return vt(), null;
        case 10:
            return Go(n.type._context), null;
        case 22:
        case 23:
            return su(), null;
        case 24:
            return null;
        default:
            return null
    }
}
var Rr = !1,
    ue = !1,
    E1 = typeof WeakSet == "function" ? WeakSet : Set,
    N = null;

function rt(e, n) {
    var t = e.ref;
    if (t !== null)
        if (typeof t == "function") try {
            t(null)
        } catch (r) {
            K(e, n, r)
        } else t.current = null
}

function so(e, n, t) {
    try {
        t()
    } catch (r) {
        K(e, n, r)
    }
}
var xa = !1;

function _1(e, n) {
    if (Ki = ol, e = Ws(), Bo(e)) {
        if ("selectionStart" in e) var t = {
            start: e.selectionStart,
            end: e.selectionEnd
        };
        else e: {
            t = (t = e.ownerDocument) && t.defaultView || window;
            var r = t.getSelection && t.getSelection();
            if (r && r.rangeCount !== 0) {
                t = r.anchorNode;
                var l = r.anchorOffset,
                    i = r.focusNode;
                r = r.focusOffset;
                try {
                    t.nodeType, i.nodeType
                } catch {
                    t = null;
                    break e
                }
                var o = 0,
                    u = -1,
                    a = -1,
                    s = 0,
                    m = 0,
                    v = e,
                    h = null;
                n: for (;;) {
                    for (var C; v !== t || l !== 0 && v.nodeType !== 3 || (u = o + l), v !== i || r !== 0 && v.nodeType !== 3 || (a = o + r), v.nodeType === 3 && (o += v.nodeValue.length), (C = v.firstChild) !== null;) h = v, v = C;
                    for (;;) {
                        if (v === e) break n;
                        if (h === t && ++s === l && (u = o), h === i && ++m === r && (a = o), (C = v.nextSibling) !== null) break;
                        v = h, h = v.parentNode
                    }
                    v = C
                }
                t = u === -1 || a === -1 ? null : {
                    start: u,
                    end: a
                }
            } else t = null
        }
        t = t || {
            start: 0,
            end: 0
        }
    } else t = null;
    for (Gi = {
        focusedElem: e,
        selectionRange: t
    }, ol = !1, N = n; N !== null;)
        if (n = N, e = n.child, (n.subtreeFlags & 1028) !== 0 && e !== null) e.return = n, N = e;
        else
            for (; N !== null;) {
                n = N;
                try {
                    var g = n.alternate;
                    if (n.flags & 1024) switch (n.tag) {
                        case 0:
                        case 11:
                        case 15:
                            break;
                        case 1:
                            if (g !== null) {
                                var x = g.memoizedProps,
                                    L = g.memoizedState,
                                    f = n.stateNode,
                                    c = f.getSnapshotBeforeUpdate(n.elementType === n.type ? x : ze(n.type, x), L);
                                f.__reactInternalSnapshotBeforeUpdate = c
                            }
                            break;
                        case 3:
                            var d = n.stateNode.containerInfo;
                            d.nodeType === 1 ? d.textContent = "" : d.nodeType === 9 && d.documentElement && d.removeChild(d.documentElement);
                            break;
                        case 5:
                        case 6:
                        case 4:
                        case 17:
                            break;
                        default:
                            throw Error(k(163))
                    }
                } catch (y) {
                    K(n, n.return, y)
                }
                if (e = n.sibling, e !== null) {
                    e.return = n.return, N = e;
                    break
                }
                N = n.return
            }
    return g = xa, xa = !1, g
}

function Wt(e, n, t) {
    var r = n.updateQueue;
    if (r = r !== null ? r.lastEffect : null, r !== null) {
        var l = r = r.next;
        do {
            if ((l.tag & e) === e) {
                var i = l.destroy;
                l.destroy = void 0, i !== void 0 && so(n, t, i)
            }
            l = l.next
        } while (l !== r)
    }
}

function Il(e, n) {
    if (n = n.updateQueue, n = n !== null ? n.lastEffect : null, n !== null) {
        var t = n = n.next;
        do {
            if ((t.tag & e) === e) {
                var r = t.create;
                t.destroy = r()
            }
            t = t.next
        } while (t !== n)
    }
}

function co(e) {
    var n = e.ref;
    if (n !== null) {
        var t = e.stateNode;
        switch (e.tag) {
            case 5:
                e = t;
                break;
            default:
                e = t
        }
        typeof n == "function" ? n(e) : n.current = e
    }
}

function Bc(e) {
    var n = e.alternate;
    n !== null && (e.alternate = null, Bc(n)), e.child = null, e.deletions = null, e.sibling = null, e.tag === 5 && (n = e.stateNode, n !== null && (delete n[$e], delete n[lr], delete n[Yi], delete n[u1], delete n[a1])), e.stateNode = null, e.return = null, e.dependencies = null, e.memoizedProps = null, e.memoizedState = null, e.pendingProps = null, e.stateNode = null, e.updateQueue = null
}

function Hc(e) {
    return e.tag === 5 || e.tag === 3 || e.tag === 4
}

function wa(e) {
    e: for (;;) {
        for (; e.sibling === null;) {
            if (e.return === null || Hc(e.return)) return null;
            e = e.return
        }
        for (e.sibling.return = e.return, e = e.sibling; e.tag !== 5 && e.tag !== 6 && e.tag !== 18;) {
            if (e.flags & 2 || e.child === null || e.tag === 4) continue e;
            e.child.return = e, e = e.child
        }
        if (!(e.flags & 2)) return e.stateNode
    }
}

function fo(e, n, t) {
    var r = e.tag;
    if (r === 5 || r === 6) e = e.stateNode, n ? t.nodeType === 8 ? t.parentNode.insertBefore(e, n) : t.insertBefore(e, n) : (t.nodeType === 8 ? (n = t.parentNode, n.insertBefore(e, t)) : (n = t, n.appendChild(e)), t = t._reactRootContainer, t != null || n.onclick !== null || (n.onclick = sl));
    else if (r !== 4 && (e = e.child, e !== null))
        for (fo(e, n, t), e = e.sibling; e !== null;) fo(e, n, t), e = e.sibling
}

function po(e, n, t) {
    var r = e.tag;
    if (r === 5 || r === 6) e = e.stateNode, n ? t.insertBefore(e, n) : t.appendChild(e);
    else if (r !== 4 && (e = e.child, e !== null))
        for (po(e, n, t), e = e.sibling; e !== null;) po(e, n, t), e = e.sibling
}
var te = null,
    Oe = !1;

function tn(e, n, t) {
    for (t = t.child; t !== null;) Vc(e, n, t), t = t.sibling
}

function Vc(e, n, t) {
    if (Be && typeof Be.onCommitFiberUnmount == "function") try {
        Be.onCommitFiberUnmount(jl, t)
    } catch {}
    switch (t.tag) {
        case 5:
            ue || rt(t, n);
        case 6:
            var r = te,
                l = Oe;
            te = null, tn(e, n, t), te = r, Oe = l, te !== null && (Oe ? (e = te, t = t.stateNode, e.nodeType === 8 ? e.parentNode.removeChild(t) : e.removeChild(t)) : te.removeChild(t.stateNode));
            break;
        case 18:
            te !== null && (Oe ? (e = te, t = t.stateNode, e.nodeType === 8 ? ai(e.parentNode, t) : e.nodeType === 1 && ai(e, t), bt(e)) : ai(te, t.stateNode));
            break;
        case 4:
            r = te, l = Oe, te = t.stateNode.containerInfo, Oe = !0, tn(e, n, t), te = r, Oe = l;
            break;
        case 0:
        case 11:
        case 14:
        case 15:
            if (!ue && (r = t.updateQueue, r !== null && (r = r.lastEffect, r !== null))) {
                l = r = r.next;
                do {
                    var i = l,
                        o = i.destroy;
                    i = i.tag, o !== void 0 && (i & 2 || i & 4) && so(t, n, o), l = l.next
                } while (l !== r)
            }
            tn(e, n, t);
            break;
        case 1:
            if (!ue && (rt(t, n), r = t.stateNode, typeof r.componentWillUnmount == "function")) try {
                r.props = t.memoizedProps, r.state = t.memoizedState, r.componentWillUnmount()
            } catch (u) {
                K(t, n, u)
            }
            tn(e, n, t);
            break;
        case 21:
            tn(e, n, t);
            break;
        case 22:
            t.mode & 1 ? (ue = (r = ue) || t.memoizedState !== null, tn(e, n, t), ue = r) : tn(e, n, t);
            break;
        default:
            tn(e, n, t)
    }
}

function Ca(e) {
    var n = e.updateQueue;
    if (n !== null) {
        e.updateQueue = null;
        var t = e.stateNode;
        t === null && (t = e.stateNode = new E1), n.forEach(function(r) {
            var l = R1.bind(null, e, r);
            t.has(r) || (t.add(r), r.then(l, l))
        })
    }
}

function De(e, n) {
    var t = n.deletions;
    if (t !== null)
        for (var r = 0; r < t.length; r++) {
            var l = t[r];
            try {
                var i = e,
                    o = n,
                    u = o;
                e: for (; u !== null;) {
                    switch (u.tag) {
                        case 5:
                            te = u.stateNode, Oe = !1;
                            break e;
                        case 3:
                            te = u.stateNode.containerInfo, Oe = !0;
                            break e;
                        case 4:
                            te = u.stateNode.containerInfo, Oe = !0;
                            break e
                    }
                    u = u.return
                }
                if (te === null) throw Error(k(160));
                Vc(i, o, l), te = null, Oe = !1;
                var a = l.alternate;
                a !== null && (a.return = null), l.return = null
            } catch (s) {
                K(l, n, s)
            }
        }
    if (n.subtreeFlags & 12854)
        for (n = n.child; n !== null;) Wc(n, e), n = n.sibling
}

function Wc(e, n) {
    var t = e.alternate,
        r = e.flags;
    switch (e.tag) {
        case 0:
        case 11:
        case 14:
        case 15:
            if (De(n, e), Ae(e), r & 4) {
                try {
                    Wt(3, e, e.return), Il(3, e)
                } catch (x) {
                    K(e, e.return, x)
                }
                try {
                    Wt(5, e, e.return)
                } catch (x) {
                    K(e, e.return, x)
                }
            }
            break;
        case 1:
            De(n, e), Ae(e), r & 512 && t !== null && rt(t, t.return);
            break;
        case 5:
            if (De(n, e), Ae(e), r & 512 && t !== null && rt(t, t.return), e.flags & 32) {
                var l = e.stateNode;
                try {
                    Xt(l, "")
                } catch (x) {
                    K(e, e.return, x)
                }
            }
            if (r & 4 && (l = e.stateNode, l != null)) {
                var i = e.memoizedProps,
                    o = t !== null ? t.memoizedProps : i,
                    u = e.type,
                    a = e.updateQueue;
                if (e.updateQueue = null, a !== null) try {
                    u === "input" && i.type === "radio" && i.name != null && fs(l, i), Mi(u, o);
                    var s = Mi(u, i);
                    for (o = 0; o < a.length; o += 2) {
                        var m = a[o],
                            v = a[o + 1];
                        m === "style" ? vs(l, v) : m === "dangerouslySetInnerHTML" ? ms(l, v) : m === "children" ? Xt(l, v) : Lo(l, m, v, s)
                    }
                    switch (u) {
                        case "input":
                            Di(l, i);
                            break;
                        case "textarea":
                            ds(l, i);
                            break;
                        case "select":
                            var h = l._wrapperState.wasMultiple;
                            l._wrapperState.wasMultiple = !!i.multiple;
                            var C = i.value;
                            C != null ? ot(l, !!i.multiple, C, !1) : h !== !!i.multiple && (i.defaultValue != null ? ot(l, !!i.multiple, i.defaultValue, !0) : ot(l, !!i.multiple, i.multiple ? [] : "", !1))
                    }
                    l[lr] = i
                } catch (x) {
                    K(e, e.return, x)
                }
            }
            break;
        case 6:
            if (De(n, e), Ae(e), r & 4) {
                if (e.stateNode === null) throw Error(k(162));
                l = e.stateNode, i = e.memoizedProps;
                try {
                    l.nodeValue = i
                } catch (x) {
                    K(e, e.return, x)
                }
            }
            break;
        case 3:
            if (De(n, e), Ae(e), r & 4 && t !== null && t.memoizedState.isDehydrated) try {
                bt(n.containerInfo)
            } catch (x) {
                K(e, e.return, x)
            }
            break;
        case 4:
            De(n, e), Ae(e);
            break;
        case 13:
            De(n, e), Ae(e), l = e.child, l.flags & 8192 && (i = l.memoizedState !== null, l.stateNode.isHidden = i, !i || l.alternate !== null && l.alternate.memoizedState !== null || (uu = Z())), r & 4 && Ca(e);
            break;
        case 22:
            if (m = t !== null && t.memoizedState !== null, e.mode & 1 ? (ue = (s = ue) || m, De(n, e), ue = s) : De(n, e), Ae(e), r & 8192) {
                if (s = e.memoizedState !== null, (e.stateNode.isHidden = s) && !m && e.mode & 1)
                    for (N = e, m = e.child; m !== null;) {
                        for (v = N = m; N !== null;) {
                            switch (h = N, C = h.child, h.tag) {
                                case 0:
                                case 11:
                                case 14:
                                case 15:
                                    Wt(4, h, h.return);
                                    break;
                                case 1:
                                    rt(h, h.return);
                                    var g = h.stateNode;
                                    if (typeof g.componentWillUnmount == "function") {
                                        r = h, t = h.return;
                                        try {
                                            n = r, g.props = n.memoizedProps, g.state = n.memoizedState, g.componentWillUnmount()
                                        } catch (x) {
                                            K(r, t, x)
                                        }
                                    }
                                    break;
                                case 5:
                                    rt(h, h.return);
                                    break;
                                case 22:
                                    if (h.memoizedState !== null) {
                                        Sa(v);
                                        continue
                                    }
                            }
                            C !== null ? (C.return = h, N = C) : Sa(v)
                        }
                        m = m.sibling
                    }
                e: for (m = null, v = e;;) {
                    if (v.tag === 5) {
                        if (m === null) {
                            m = v;
                            try {
                                l = v.stateNode, s ? (i = l.style, typeof i.setProperty == "function" ? i.setProperty("display", "none", "important") : i.display = "none") : (u = v.stateNode, a = v.memoizedProps.style, o = a != null && a.hasOwnProperty("display") ? a.display : null, u.style.display = hs("display", o))
                            } catch (x) {
                                K(e, e.return, x)
                            }
                        }
                    } else if (v.tag === 6) {
                        if (m === null) try {
                            v.stateNode.nodeValue = s ? "" : v.memoizedProps
                        } catch (x) {
                            K(e, e.return, x)
                        }
                    } else if ((v.tag !== 22 && v.tag !== 23 || v.memoizedState === null || v === e) && v.child !== null) {
                        v.child.return = v, v = v.child;
                        continue
                    }
                    if (v === e) break e;
                    for (; v.sibling === null;) {
                        if (v.return === null || v.return === e) break e;
                        m === v && (m = null), v = v.return
                    }
                    m === v && (m = null), v.sibling.return = v.return, v = v.sibling
                }
            }
            break;
        case 19:
            De(n, e), Ae(e), r & 4 && Ca(e);
            break;
        case 21:
            break;
        default:
            De(n, e), Ae(e)
    }
}

function Ae(e) {
    var n = e.flags;
    if (n & 2) {
        try {
            e: {
                for (var t = e.return; t !== null;) {
                    if (Hc(t)) {
                        var r = t;
                        break e
                    }
                    t = t.return
                }
                throw Error(k(160))
            }
            switch (r.tag) {
                case 5:
                    var l = r.stateNode;
                    r.flags & 32 && (Xt(l, ""), r.flags &= -33);
                    var i = wa(e);
                    po(e, i, l);
                    break;
                case 3:
                case 4:
                    var o = r.stateNode.containerInfo,
                        u = wa(e);
                    fo(e, u, o);
                    break;
                default:
                    throw Error(k(161))
            }
        }
        catch (a) {
            K(e, e.return, a)
        }
        e.flags &= -3
    }
    n & 4096 && (e.flags &= -4097)
}

function N1(e, n, t) {
    N = e, Qc(e)
}

function Qc(e, n, t) {
    for (var r = (e.mode & 1) !== 0; N !== null;) {
        var l = N,
            i = l.child;
        if (l.tag === 22 && r) {
            var o = l.memoizedState !== null || Rr;
            if (!o) {
                var u = l.alternate,
                    a = u !== null && u.memoizedState !== null || ue;
                u = Rr;
                var s = ue;
                if (Rr = o, (ue = a) && !s)
                    for (N = l; N !== null;) o = N, a = o.child, o.tag === 22 && o.memoizedState !== null ? Ea(l) : a !== null ? (a.return = o, N = a) : Ea(l);
                for (; i !== null;) N = i, Qc(i), i = i.sibling;
                N = l, Rr = u, ue = s
            }
            ka(e)
        } else l.subtreeFlags & 8772 && i !== null ? (i.return = l, N = i) : ka(e)
    }
}

function ka(e) {
    for (; N !== null;) {
        var n = N;
        if (n.flags & 8772) {
            var t = n.alternate;
            try {
                if (n.flags & 8772) switch (n.tag) {
                    case 0:
                    case 11:
                    case 15:
                        ue || Il(5, n);
                        break;
                    case 1:
                        var r = n.stateNode;
                        if (n.flags & 4 && !ue)
                            if (t === null) r.componentDidMount();
                            else {
                                var l = n.elementType === n.type ? t.memoizedProps : ze(n.type, t.memoizedProps);
                                r.componentDidUpdate(l, t.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                            } var i = n.updateQueue;
                        i !== null && ia(n, i, r);
                        break;
                    case 3:
                        var o = n.updateQueue;
                        if (o !== null) {
                            if (t = null, n.child !== null) switch (n.child.tag) {
                                case 5:
                                    t = n.child.stateNode;
                                    break;
                                case 1:
                                    t = n.child.stateNode
                            }
                            ia(n, o, t)
                        }
                        break;
                    case 5:
                        var u = n.stateNode;
                        if (t === null && n.flags & 4) {
                            t = u;
                            var a = n.memoizedProps;
                            switch (n.type) {
                                case "button":
                                case "input":
                                case "select":
                                case "textarea":
                                    a.autoFocus && t.focus();
                                    break;
                                case "img":
                                    a.src && (t.src = a.src)
                            }
                        }
                        break;
                    case 6:
                        break;
                    case 4:
                        break;
                    case 12:
                        break;
                    case 13:
                        if (n.memoizedState === null) {
                            var s = n.alternate;
                            if (s !== null) {
                                var m = s.memoizedState;
                                if (m !== null) {
                                    var v = m.dehydrated;
                                    v !== null && bt(v)
                                }
                            }
                        }
                        break;
                    case 19:
                    case 17:
                    case 21:
                    case 22:
                    case 23:
                    case 25:
                        break;
                    default:
                        throw Error(k(163))
                }
                ue || n.flags & 512 && co(n)
            } catch (h) {
                K(n, n.return, h)
            }
        }
        if (n === e) {
            N = null;
            break
        }
        if (t = n.sibling, t !== null) {
            t.return = n.return, N = t;
            break
        }
        N = n.return
    }
}

function Sa(e) {
    for (; N !== null;) {
        var n = N;
        if (n === e) {
            N = null;
            break
        }
        var t = n.sibling;
        if (t !== null) {
            t.return = n.return, N = t;
            break
        }
        N = n.return
    }
}

function Ea(e) {
    for (; N !== null;) {
        var n = N;
        try {
            switch (n.tag) {
                case 0:
                case 11:
                case 15:
                    var t = n.return;
                    try {
                        Il(4, n)
                    } catch (a) {
                        K(n, t, a)
                    }
                    break;
                case 1:
                    var r = n.stateNode;
                    if (typeof r.componentDidMount == "function") {
                        var l = n.return;
                        try {
                            r.componentDidMount()
                        } catch (a) {
                            K(n, l, a)
                        }
                    }
                    var i = n.return;
                    try {
                        co(n)
                    } catch (a) {
                        K(n, i, a)
                    }
                    break;
                case 5:
                    var o = n.return;
                    try {
                        co(n)
                    } catch (a) {
                        K(n, o, a)
                    }
            }
        } catch (a) {
            K(n, n.return, a)
        }
        if (n === e) {
            N = null;
            break
        }
        var u = n.sibling;
        if (u !== null) {
            u.return = n.return, N = u;
            break
        }
        N = n.return
    }
}
var j1 = Math.ceil,
    wl = en.ReactCurrentDispatcher,
    iu = en.ReactCurrentOwner,
    je = en.ReactCurrentBatchConfig,
    I = 0,
    ne = null,
    X = null,
    re = 0,
    ye = 0,
    lt = Cn(0),
    J = 0,
    cr = null,
    An = 0,
    Ml = 0,
    ou = 0,
    Qt = null,
    pe = null,
    uu = 0,
    yt = 1 / 0,
    Qe = null,
    Cl = !1,
    mo = null,
    hn = null,
    Ir = !1,
    sn = null,
    kl = 0,
    Kt = 0,
    ho = null,
    qr = -1,
    br = 0;

function ce() {
    return I & 6 ? Z() : qr !== -1 ? qr : qr = Z()
}

function vn(e) {
    return e.mode & 1 ? I & 2 && re !== 0 ? re & -re : c1.transition !== null ? (br === 0 && (br = Ls()), br) : (e = M, e !== 0 || (e = window.event, e = e === void 0 ? 16 : Is(e.type)), e) : 1
}

function Me(e, n, t, r) {
    if (50 < Kt) throw Kt = 0, ho = null, Error(k(185));
    dr(e, t, r), (!(I & 2) || e !== ne) && (e === ne && (!(I & 2) && (Ml |= t), J === 4 && un(e, re)), ge(e, r), t === 1 && I === 0 && !(n.mode & 1) && (yt = Z() + 500, zl && kn()))
}

function ge(e, n) {
    var t = e.callbackNode;
    cd(e, n);
    var r = il(e, e === ne ? re : 0);
    if (r === 0) t !== null && Ou(t), e.callbackNode = null, e.callbackPriority = 0;
    else if (n = r & -r, e.callbackPriority !== n) {
        if (t != null && Ou(t), n === 1) e.tag === 0 ? s1(_a.bind(null, e)) : ec(_a.bind(null, e)), i1(function() {
            !(I & 6) && kn()
        }), t = null;
        else {
            switch (Ts(r)) {
                case 1:
                    t = Oo;
                    break;
                case 4:
                    t = Ns;
                    break;
                case 16:
                    t = ll;
                    break;
                case 536870912:
                    t = js;
                    break;
                default:
                    t = ll
            }
            t = bc(t, Kc.bind(null, e))
        }
        e.callbackPriority = n, e.callbackNode = t
    }
}

function Kc(e, n) {
    if (qr = -1, br = 0, I & 6) throw Error(k(327));
    var t = e.callbackNode;
    if (ft() && e.callbackNode !== t) return null;
    var r = il(e, e === ne ? re : 0);
    if (r === 0) return null;
    if (r & 30 || r & e.expiredLanes || n) n = Sl(e, r);
    else {
        n = r;
        var l = I;
        I |= 2;
        var i = Zc();
        (ne !== e || re !== n) && (Qe = null, yt = Z() + 500, zn(e, n));
        do try {
            P1();
            break
        } catch (u) {
            Gc(e, u)
        }
        while (1);
        Ko(), wl.current = i, I = l, X !== null ? n = 0 : (ne = null, re = 0, n = J)
    }
    if (n !== 0) {
        if (n === 2 && (l = Bi(e), l !== 0 && (r = l, n = vo(e, l))), n === 1) throw t = cr, zn(e, 0), un(e, r), ge(e, Z()), t;
        if (n === 6) un(e, r);
        else {
            if (l = e.current.alternate, !(r & 30) && !L1(l) && (n = Sl(e, r), n === 2 && (i = Bi(e), i !== 0 && (r = i, n = vo(e, i))), n === 1)) throw t = cr, zn(e, 0), un(e, r), ge(e, Z()), t;
            switch (e.finishedWork = l, e.finishedLanes = r, n) {
                case 0:
                case 1:
                    throw Error(k(345));
                case 2:
                    Nn(e, pe, Qe);
                    break;
                case 3:
                    if (un(e, r), (r & 130023424) === r && (n = uu + 500 - Z(), 10 < n)) {
                        if (il(e, 0) !== 0) break;
                        if (l = e.suspendedLanes, (l & r) !== r) {
                            ce(), e.pingedLanes |= e.suspendedLanes & l;
                            break
                        }
                        e.timeoutHandle = Xi(Nn.bind(null, e, pe, Qe), n);
                        break
                    }
                    Nn(e, pe, Qe);
                    break;
                case 4:
                    if (un(e, r), (r & 4194240) === r) break;
                    for (n = e.eventTimes, l = -1; 0 < r;) {
                        var o = 31 - Ie(r);
                        i = 1 << o, o = n[o], o > l && (l = o), r &= ~i
                    }
                    if (r = l, r = Z() - r, r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * j1(r / 1960)) - r, 10 < r) {
                        e.timeoutHandle = Xi(Nn.bind(null, e, pe, Qe), r);
                        break
                    }
                    Nn(e, pe, Qe);
                    break;
                case 5:
                    Nn(e, pe, Qe);
                    break;
                default:
                    throw Error(k(329))
            }
        }
    }
    return ge(e, Z()), e.callbackNode === t ? Kc.bind(null, e) : null
}

function vo(e, n) {
    var t = Qt;
    return e.current.memoizedState.isDehydrated && (zn(e, n).flags |= 256), e = Sl(e, n), e !== 2 && (n = pe, pe = t, n !== null && go(n)), e
}

function go(e) {
    pe === null ? pe = e : pe.push.apply(pe, e)
}

function L1(e) {
    for (var n = e;;) {
        if (n.flags & 16384) {
            var t = n.updateQueue;
            if (t !== null && (t = t.stores, t !== null))
                for (var r = 0; r < t.length; r++) {
                    var l = t[r],
                        i = l.getSnapshot;
                    l = l.value;
                    try {
                        if (!Fe(i(), l)) return !1
                    } catch {
                        return !1
                    }
                }
        }
        if (t = n.child, n.subtreeFlags & 16384 && t !== null) t.return = n, n = t;
        else {
            if (n === e) break;
            for (; n.sibling === null;) {
                if (n.return === null || n.return === e) return !0;
                n = n.return
            }
            n.sibling.return = n.return, n = n.sibling
        }
    }
    return !0
}

function un(e, n) {
    for (n &= ~ou, n &= ~Ml, e.suspendedLanes |= n, e.pingedLanes &= ~n, e = e.expirationTimes; 0 < n;) {
        var t = 31 - Ie(n),
            r = 1 << t;
        e[t] = -1, n &= ~r
    }
}

function _a(e) {
    if (I & 6) throw Error(k(327));
    ft();
    var n = il(e, 0);
    if (!(n & 1)) return ge(e, Z()), null;
    var t = Sl(e, n);
    if (e.tag !== 0 && t === 2) {
        var r = Bi(e);
        r !== 0 && (n = r, t = vo(e, r))
    }
    if (t === 1) throw t = cr, zn(e, 0), un(e, n), ge(e, Z()), t;
    if (t === 6) throw Error(k(345));
    return e.finishedWork = e.current.alternate, e.finishedLanes = n, Nn(e, pe, Qe), ge(e, Z()), null
}

function au(e, n) {
    var t = I;
    I |= 1;
    try {
        return e(n)
    } finally {
        I = t, I === 0 && (yt = Z() + 500, zl && kn())
    }
}

function Un(e) {
    sn !== null && sn.tag === 0 && !(I & 6) && ft();
    var n = I;
    I |= 1;
    var t = je.transition,
        r = M;
    try {
        if (je.transition = null, M = 1, e) return e()
    } finally {
        M = r, je.transition = t, I = n, !(I & 6) && kn()
    }
}

function su() {
    ye = lt.current, B(lt)
}

function zn(e, n) {
    e.finishedWork = null, e.finishedLanes = 0;
    var t = e.timeoutHandle;
    if (t !== -1 && (e.timeoutHandle = -1, l1(t)), X !== null)
        for (t = X.return; t !== null;) {
            var r = t;
            switch (Vo(r), r.tag) {
                case 1:
                    r = r.type.childContextTypes, r != null && cl();
                    break;
                case 3:
                    vt(), B(he), B(ae), qo();
                    break;
                case 5:
                    Jo(r);
                    break;
                case 4:
                    vt();
                    break;
                case 13:
                    B(V);
                    break;
                case 19:
                    B(V);
                    break;
                case 10:
                    Go(r.type._context);
                    break;
                case 22:
                case 23:
                    su()
            }
            t = t.return
        }
    if (ne = e, X = e = gn(e.current, null), re = ye = n, J = 0, cr = null, ou = Ml = An = 0, pe = Qt = null, Pn !== null) {
        for (n = 0; n < Pn.length; n++)
            if (t = Pn[n], r = t.interleaved, r !== null) {
                t.interleaved = null;
                var l = r.next,
                    i = t.pending;
                if (i !== null) {
                    var o = i.next;
                    i.next = l, r.next = o
                }
                t.pending = r
            } Pn = null
    }
    return e
}

function Gc(e, n) {
    do {
        var t = X;
        try {
            if (Ko(), Xr.current = xl, yl) {
                for (var r = W.memoizedState; r !== null;) {
                    var l = r.queue;
                    l !== null && (l.pending = null), r = r.next
                }
                yl = !1
            }
            if (Fn = 0, ee = Y = W = null, Vt = !1, ur = 0, iu.current = null, t === null || t.return === null) {
                J = 1, cr = n, X = null;
                break
            }
            e: {
                var i = e,
                    o = t.return,
                    u = t,
                    a = n;
                if (n = re, u.flags |= 32768, a !== null && typeof a == "object" && typeof a.then == "function") {
                    var s = a,
                        m = u,
                        v = m.tag;
                    if (!(m.mode & 1) && (v === 0 || v === 11 || v === 15)) {
                        var h = m.alternate;
                        h ? (m.updateQueue = h.updateQueue, m.memoizedState = h.memoizedState, m.lanes = h.lanes) : (m.updateQueue = null, m.memoizedState = null)
                    }
                    var C = da(o);
                    if (C !== null) {
                        C.flags &= -257, pa(C, o, u, i, n), C.mode & 1 && fa(i, s, n), n = C, a = s;
                        var g = n.updateQueue;
                        if (g === null) {
                            var x = new Set;
                            x.add(a), n.updateQueue = x
                        } else g.add(a);
                        break e
                    } else {
                        if (!(n & 1)) {
                            fa(i, s, n), cu();
                            break e
                        }
                        a = Error(k(426))
                    }
                } else if (H && u.mode & 1) {
                    var L = da(o);
                    if (L !== null) {
                        !(L.flags & 65536) && (L.flags |= 256), pa(L, o, u, i, n), Wo(gt(a, u));
                        break e
                    }
                }
                i = a = gt(a, u),
                J !== 4 && (J = 2),
                    Qt === null ? Qt = [i] : Qt.push(i),
                    i = o;do {
                    switch (i.tag) {
                        case 3:
                            i.flags |= 65536, n &= -n, i.lanes |= n;
                            var f = Pc(i, a, n);
                            la(i, f);
                            break e;
                        case 1:
                            u = a;
                            var c = i.type,
                                d = i.stateNode;
                            if (!(i.flags & 128) && (typeof c.getDerivedStateFromError == "function" || d !== null && typeof d.componentDidCatch == "function" && (hn === null || !hn.has(d)))) {
                                i.flags |= 65536, n &= -n, i.lanes |= n;
                                var y = Dc(i, u, n);
                                la(i, y);
                                break e
                            }
                    }
                    i = i.return
                } while (i !== null)
            }
            Yc(t)
        } catch (S) {
            n = S, X === t && t !== null && (X = t = t.return);
            continue
        }
        break
    } while (1)
}

function Zc() {
    var e = wl.current;
    return wl.current = xl, e === null ? xl : e
}

function cu() {
    (J === 0 || J === 3 || J === 2) && (J = 4), ne === null || !(An & 268435455) && !(Ml & 268435455) || un(ne, re)
}

function Sl(e, n) {
    var t = I;
    I |= 2;
    var r = Zc();
    (ne !== e || re !== n) && (Qe = null, zn(e, n));
    do try {
        T1();
        break
    } catch (l) {
        Gc(e, l)
    }
    while (1);
    if (Ko(), I = t, wl.current = r, X !== null) throw Error(k(261));
    return ne = null, re = 0, J
}

function T1() {
    for (; X !== null;) Xc(X)
}

function P1() {
    for (; X !== null && !nd();) Xc(X)
}

function Xc(e) {
    var n = qc(e.alternate, e, ye);
    e.memoizedProps = e.pendingProps, n === null ? Yc(e) : X = n, iu.current = null
}

function Yc(e) {
    var n = e;
    do {
        var t = n.alternate;
        if (e = n.return, n.flags & 32768) {
            if (t = S1(t, n), t !== null) {
                t.flags &= 32767, X = t;
                return
            }
            if (e !== null) e.flags |= 32768, e.subtreeFlags = 0, e.deletions = null;
            else {
                J = 6, X = null;
                return
            }
        } else if (t = k1(t, n, ye), t !== null) {
            X = t;
            return
        }
        if (n = n.sibling, n !== null) {
            X = n;
            return
        }
        X = n = e
    } while (n !== null);
    J === 0 && (J = 5)
}

function Nn(e, n, t) {
    var r = M,
        l = je.transition;
    try {
        je.transition = null, M = 1, D1(e, n, t, r)
    } finally {
        je.transition = l, M = r
    }
    return null
}

function D1(e, n, t, r) {
    do ft(); while (sn !== null);
    if (I & 6) throw Error(k(327));
    t = e.finishedWork;
    var l = e.finishedLanes;
    if (t === null) return null;
    if (e.finishedWork = null, e.finishedLanes = 0, t === e.current) throw Error(k(177));
    e.callbackNode = null, e.callbackPriority = 0;
    var i = t.lanes | t.childLanes;
    if (fd(e, i), e === ne && (X = ne = null, re = 0), !(t.subtreeFlags & 2064) && !(t.flags & 2064) || Ir || (Ir = !0, bc(ll, function() {
        return ft(), null
    })), i = (t.flags & 15990) !== 0, t.subtreeFlags & 15990 || i) {
        i = je.transition, je.transition = null;
        var o = M;
        M = 1;
        var u = I;
        I |= 4, iu.current = null, _1(e, t), Wc(t, e), Jd(Gi), ol = !!Ki, Gi = Ki = null, e.current = t, N1(t), td(), I = u, M = o, je.transition = i
    } else e.current = t;
    if (Ir && (Ir = !1, sn = e, kl = l), i = e.pendingLanes, i === 0 && (hn = null), id(t.stateNode), ge(e, Z()), n !== null)
        for (r = e.onRecoverableError, t = 0; t < n.length; t++) l = n[t], r(l.value, {
            componentStack: l.stack,
            digest: l.digest
        });
    if (Cl) throw Cl = !1, e = mo, mo = null, e;
    return kl & 1 && e.tag !== 0 && ft(), i = e.pendingLanes, i & 1 ? e === ho ? Kt++ : (Kt = 0, ho = e) : Kt = 0, kn(), null
}

function ft() {
    if (sn !== null) {
        var e = Ts(kl),
            n = je.transition,
            t = M;
        try {
            if (je.transition = null, M = 16 > e ? 16 : e, sn === null) var r = !1;
            else {
                if (e = sn, sn = null, kl = 0, I & 6) throw Error(k(331));
                var l = I;
                for (I |= 4, N = e.current; N !== null;) {
                    var i = N,
                        o = i.child;
                    if (N.flags & 16) {
                        var u = i.deletions;
                        if (u !== null) {
                            for (var a = 0; a < u.length; a++) {
                                var s = u[a];
                                for (N = s; N !== null;) {
                                    var m = N;
                                    switch (m.tag) {
                                        case 0:
                                        case 11:
                                        case 15:
                                            Wt(8, m, i)
                                    }
                                    var v = m.child;
                                    if (v !== null) v.return = m, N = v;
                                    else
                                        for (; N !== null;) {
                                            m = N;
                                            var h = m.sibling,
                                                C = m.return;
                                            if (Bc(m), m === s) {
                                                N = null;
                                                break
                                            }
                                            if (h !== null) {
                                                h.return = C, N = h;
                                                break
                                            }
                                            N = C
                                        }
                                }
                            }
                            var g = i.alternate;
                            if (g !== null) {
                                var x = g.child;
                                if (x !== null) {
                                    g.child = null;
                                    do {
                                        var L = x.sibling;
                                        x.sibling = null, x = L
                                    } while (x !== null)
                                }
                            }
                            N = i
                        }
                    }
                    if (i.subtreeFlags & 2064 && o !== null) o.return = i, N = o;
                    else e: for (; N !== null;) {
                        if (i = N, i.flags & 2048) switch (i.tag) {
                            case 0:
                            case 11:
                            case 15:
                                Wt(9, i, i.return)
                        }
                        var f = i.sibling;
                        if (f !== null) {
                            f.return = i.return, N = f;
                            break e
                        }
                        N = i.return
                    }
                }
                var c = e.current;
                for (N = c; N !== null;) {
                    o = N;
                    var d = o.child;
                    if (o.subtreeFlags & 2064 && d !== null) d.return = o, N = d;
                    else e: for (o = c; N !== null;) {
                        if (u = N, u.flags & 2048) try {
                            switch (u.tag) {
                                case 0:
                                case 11:
                                case 15:
                                    Il(9, u)
                            }
                        } catch (S) {
                            K(u, u.return, S)
                        }
                        if (u === o) {
                            N = null;
                            break e
                        }
                        var y = u.sibling;
                        if (y !== null) {
                            y.return = u.return, N = y;
                            break e
                        }
                        N = u.return
                    }
                }
                if (I = l, kn(), Be && typeof Be.onPostCommitFiberRoot == "function") try {
                    Be.onPostCommitFiberRoot(jl, e)
                } catch {}
                r = !0
            }
            return r
        } finally {
            M = t, je.transition = n
        }
    }
    return !1
}

function Na(e, n, t) {
    n = gt(t, n), n = Pc(e, n, 1), e = mn(e, n, 1), n = ce(), e !== null && (dr(e, 1, n), ge(e, n))
}

function K(e, n, t) {
    if (e.tag === 3) Na(e, e, t);
    else
        for (; n !== null;) {
            if (n.tag === 3) {
                Na(n, e, t);
                break
            } else if (n.tag === 1) {
                var r = n.stateNode;
                if (typeof n.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (hn === null || !hn.has(r))) {
                    e = gt(t, e), e = Dc(n, e, 1), n = mn(n, e, 1), e = ce(), n !== null && (dr(n, 1, e), ge(n, e));
                    break
                }
            }
            n = n.return
        }
}

function z1(e, n, t) {
    var r = e.pingCache;
    r !== null && r.delete(n), n = ce(), e.pingedLanes |= e.suspendedLanes & t, ne === e && (re & t) === t && (J === 4 || J === 3 && (re & 130023424) === re && 500 > Z() - uu ? zn(e, 0) : ou |= t), ge(e, n)
}

function Jc(e, n) {
    n === 0 && (e.mode & 1 ? (n = _r, _r <<= 1, !(_r & 130023424) && (_r = 4194304)) : n = 1);
    var t = ce();
    e = qe(e, n), e !== null && (dr(e, n, t), ge(e, t))
}

function O1(e) {
    var n = e.memoizedState,
        t = 0;
    n !== null && (t = n.retryLane), Jc(e, t)
}

function R1(e, n) {
    var t = 0;
    switch (e.tag) {
        case 13:
            var r = e.stateNode,
                l = e.memoizedState;
            l !== null && (t = l.retryLane);
            break;
        case 19:
            r = e.stateNode;
            break;
        default:
            throw Error(k(314))
    }
    r !== null && r.delete(n), Jc(e, t)
}
var qc;
qc = function(e, n, t) {
    if (e !== null)
        if (e.memoizedProps !== n.pendingProps || he.current) me = !0;
        else {
            if (!(e.lanes & t) && !(n.flags & 128)) return me = !1, C1(e, n, t);
            me = !!(e.flags & 131072)
        }
    else me = !1, H && n.flags & 1048576 && nc(n, pl, n.index);
    switch (n.lanes = 0, n.tag) {
        case 2:
            var r = n.type;
            Jr(e, n), e = n.pendingProps;
            var l = pt(n, ae.current);
            ct(n, t), l = eu(null, n, r, e, l, t);
            var i = nu();
            return n.flags |= 1, typeof l == "object" && l !== null && typeof l.render == "function" && l.$$typeof === void 0 ? (n.tag = 1, n.memoizedState = null, n.updateQueue = null, ve(r) ? (i = !0, fl(n)) : i = !1, n.memoizedState = l.state !== null && l.state !== void 0 ? l.state : null, Xo(n), l.updater = Ol, n.stateNode = l, l._reactInternals = n, to(n, r, e, t), n = io(null, n, r, !0, i, t)) : (n.tag = 0, H && i && Ho(n), se(null, n, l, t), n = n.child), n;
        case 16:
            r = n.elementType;
            e: {
                switch (Jr(e, n), e = n.pendingProps, l = r._init, r = l(r._payload), n.type = r, l = n.tag = M1(r), e = ze(r, e), l) {
                    case 0:
                        n = lo(null, n, r, e, t);
                        break e;
                    case 1:
                        n = va(null, n, r, e, t);
                        break e;
                    case 11:
                        n = ma(null, n, r, e, t);
                        break e;
                    case 14:
                        n = ha(null, n, r, ze(r.type, e), t);
                        break e
                }
                throw Error(k(306, r, ""))
            }
            return n;
        case 0:
            return r = n.type, l = n.pendingProps, l = n.elementType === r ? l : ze(r, l), lo(e, n, r, l, t);
        case 1:
            return r = n.type, l = n.pendingProps, l = n.elementType === r ? l : ze(r, l), va(e, n, r, l, t);
        case 3:
            e: {
                if (Ic(n), e === null) throw Error(k(387));r = n.pendingProps,
                    i = n.memoizedState,
                    l = i.element,
                    ic(e, n),
                    vl(n, r, null, t);
                var o = n.memoizedState;
                if (r = o.element, i.isDehydrated)
                    if (i = {
                        element: r,
                        isDehydrated: !1,
                        cache: o.cache,
                        pendingSuspenseBoundaries: o.pendingSuspenseBoundaries,
                        transitions: o.transitions
                    }, n.updateQueue.baseState = i, n.memoizedState = i, n.flags & 256) {
                        l = gt(Error(k(423)), n), n = ga(e, n, r, t, l);
                        break e
                    } else if (r !== l) {
                        l = gt(Error(k(424)), n), n = ga(e, n, r, t, l);
                        break e
                    } else
                        for (xe = pn(n.stateNode.containerInfo.firstChild), we = n, H = !0, Re = null, t = sc(n, null, r, t), n.child = t; t;) t.flags = t.flags & -3 | 4096, t = t.sibling;
                else {
                    if (mt(), r === l) {
                        n = be(e, n, t);
                        break e
                    }
                    se(e, n, r, t)
                }
                n = n.child
            }
            return n;
        case 5:
            return cc(n), e === null && bi(n), r = n.type, l = n.pendingProps, i = e !== null ? e.memoizedProps : null, o = l.children, Zi(r, l) ? o = null : i !== null && Zi(r, i) && (n.flags |= 32), Rc(e, n), se(e, n, o, t), n.child;
        case 6:
            return e === null && bi(n), null;
        case 13:
            return Mc(e, n, t);
        case 4:
            return Yo(n, n.stateNode.containerInfo), r = n.pendingProps, e === null ? n.child = ht(n, null, r, t) : se(e, n, r, t), n.child;
        case 11:
            return r = n.type, l = n.pendingProps, l = n.elementType === r ? l : ze(r, l), ma(e, n, r, l, t);
        case 7:
            return se(e, n, n.pendingProps, t), n.child;
        case 8:
            return se(e, n, n.pendingProps.children, t), n.child;
        case 12:
            return se(e, n, n.pendingProps.children, t), n.child;
        case 10:
            e: {
                if (r = n.type._context, l = n.pendingProps, i = n.memoizedProps, o = l.value, U(ml, r._currentValue), r._currentValue = o, i !== null)
                    if (Fe(i.value, o)) {
                        if (i.children === l.children && !he.current) {
                            n = be(e, n, t);
                            break e
                        }
                    } else
                        for (i = n.child, i !== null && (i.return = n); i !== null;) {
                            var u = i.dependencies;
                            if (u !== null) {
                                o = i.child;
                                for (var a = u.firstContext; a !== null;) {
                                    if (a.context === r) {
                                        if (i.tag === 1) {
                                            a = Xe(-1, t & -t), a.tag = 2;
                                            var s = i.updateQueue;
                                            if (s !== null) {
                                                s = s.shared;
                                                var m = s.pending;
                                                m === null ? a.next = a : (a.next = m.next, m.next = a), s.pending = a
                                            }
                                        }
                                        i.lanes |= t, a = i.alternate, a !== null && (a.lanes |= t), eo(i.return, t, n), u.lanes |= t;
                                        break
                                    }
                                    a = a.next
                                }
                            } else if (i.tag === 10) o = i.type === n.type ? null : i.child;
                            else if (i.tag === 18) {
                                if (o = i.return, o === null) throw Error(k(341));
                                o.lanes |= t, u = o.alternate, u !== null && (u.lanes |= t), eo(o, t, n), o = i.sibling
                            } else o = i.child;
                            if (o !== null) o.return = i;
                            else
                                for (o = i; o !== null;) {
                                    if (o === n) {
                                        o = null;
                                        break
                                    }
                                    if (i = o.sibling, i !== null) {
                                        i.return = o.return, o = i;
                                        break
                                    }
                                    o = o.return
                                }
                            i = o
                        }
                se(e, n, l.children, t),
                    n = n.child
            }
            return n;
        case 9:
            return l = n.type, r = n.pendingProps.children, ct(n, t), l = Le(l), r = r(l), n.flags |= 1, se(e, n, r, t), n.child;
        case 14:
            return r = n.type, l = ze(r, n.pendingProps), l = ze(r.type, l), ha(e, n, r, l, t);
        case 15:
            return zc(e, n, n.type, n.pendingProps, t);
        case 17:
            return r = n.type, l = n.pendingProps, l = n.elementType === r ? l : ze(r, l), Jr(e, n), n.tag = 1, ve(r) ? (e = !0, fl(n)) : e = !1, ct(n, t), uc(n, r, l), to(n, r, l, t), io(null, n, r, !0, e, t);
        case 19:
            return Fc(e, n, t);
        case 22:
            return Oc(e, n, t)
    }
    throw Error(k(156, n.tag))
};

function bc(e, n) {
    return _s(e, n)
}

function I1(e, n, t, r) {
    this.tag = e, this.key = t, this.sibling = this.child = this.return = this.stateNode = this.type = this.elementType = null, this.index = 0, this.ref = null, this.pendingProps = n, this.dependencies = this.memoizedState = this.updateQueue = this.memoizedProps = null, this.mode = r, this.subtreeFlags = this.flags = 0, this.deletions = null, this.childLanes = this.lanes = 0, this.alternate = null
}

function Ne(e, n, t, r) {
    return new I1(e, n, t, r)
}

function fu(e) {
    return e = e.prototype, !(!e || !e.isReactComponent)
}

function M1(e) {
    if (typeof e == "function") return fu(e) ? 1 : 0;
    if (e != null) {
        if (e = e.$$typeof, e === Po) return 11;
        if (e === Do) return 14
    }
    return 2
}

function gn(e, n) {
    var t = e.alternate;
    return t === null ? (t = Ne(e.tag, n, e.key, e.mode), t.elementType = e.elementType, t.type = e.type, t.stateNode = e.stateNode, t.alternate = e, e.alternate = t) : (t.pendingProps = n, t.type = e.type, t.flags = 0, t.subtreeFlags = 0, t.deletions = null), t.flags = e.flags & 14680064, t.childLanes = e.childLanes, t.lanes = e.lanes, t.child = e.child, t.memoizedProps = e.memoizedProps, t.memoizedState = e.memoizedState, t.updateQueue = e.updateQueue, n = e.dependencies, t.dependencies = n === null ? null : {
        lanes: n.lanes,
        firstContext: n.firstContext
    }, t.sibling = e.sibling, t.index = e.index, t.ref = e.ref, t
}

function el(e, n, t, r, l, i) {
    var o = 2;
    if (r = e, typeof e == "function") fu(e) && (o = 1);
    else if (typeof e == "string") o = 5;
    else e: switch (e) {
            case Zn:
                return On(t.children, l, i, n);
            case To:
                o = 8, l |= 8;
                break;
            case Ni:
                return e = Ne(12, t, n, l | 2), e.elementType = Ni, e.lanes = i, e;
            case ji:
                return e = Ne(13, t, n, l), e.elementType = ji, e.lanes = i, e;
            case Li:
                return e = Ne(19, t, n, l), e.elementType = Li, e.lanes = i, e;
            case as:
                return Fl(t, l, i, n);
            default:
                if (typeof e == "object" && e !== null) switch (e.$$typeof) {
                    case os:
                        o = 10;
                        break e;
                    case us:
                        o = 9;
                        break e;
                    case Po:
                        o = 11;
                        break e;
                    case Do:
                        o = 14;
                        break e;
                    case rn:
                        o = 16, r = null;
                        break e
                }
                throw Error(k(130, e == null ? e : typeof e, ""))
        }
    return n = Ne(o, t, n, l), n.elementType = e, n.type = r, n.lanes = i, n
}

function On(e, n, t, r) {
    return e = Ne(7, e, r, n), e.lanes = t, e
}

function Fl(e, n, t, r) {
    return e = Ne(22, e, r, n), e.elementType = as, e.lanes = t, e.stateNode = {
        isHidden: !1
    }, e
}

function vi(e, n, t) {
    return e = Ne(6, e, null, n), e.lanes = t, e
}

function gi(e, n, t) {
    return n = Ne(4, e.children !== null ? e.children : [], e.key, n), n.lanes = t, n.stateNode = {
        containerInfo: e.containerInfo,
        pendingChildren: null,
        implementation: e.implementation
    }, n
}

function F1(e, n, t, r, l) {
    this.tag = n, this.containerInfo = e, this.finishedWork = this.pingCache = this.current = this.pendingChildren = null, this.timeoutHandle = -1, this.callbackNode = this.pendingContext = this.context = null, this.callbackPriority = 0, this.eventTimes = Jl(0), this.expirationTimes = Jl(-1), this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0, this.entanglements = Jl(0), this.identifierPrefix = r, this.onRecoverableError = l, this.mutableSourceEagerHydrationData = null
}

function du(e, n, t, r, l, i, o, u, a) {
    return e = new F1(e, n, t, u, a), n === 1 ? (n = 1, i === !0 && (n |= 8)) : n = 0, i = Ne(3, null, null, n), e.current = i, i.stateNode = e, i.memoizedState = {
        element: r,
        isDehydrated: t,
        cache: null,
        transitions: null,
        pendingSuspenseBoundaries: null
    }, Xo(i), e
}

function A1(e, n, t) {
    var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
    return {
        $$typeof: Gn,
        key: r == null ? null : "" + r,
        children: e,
        containerInfo: n,
        implementation: t
    }
}

function ef(e) {
    if (!e) return xn;
    e = e._reactInternals;
    e: {
        if (Bn(e) !== e || e.tag !== 1) throw Error(k(170));
        var n = e;do {
            switch (n.tag) {
                case 3:
                    n = n.stateNode.context;
                    break e;
                case 1:
                    if (ve(n.type)) {
                        n = n.stateNode.__reactInternalMemoizedMergedChildContext;
                        break e
                    }
            }
            n = n.return
        } while (n !== null);
        throw Error(k(171))
    }
    if (e.tag === 1) {
        var t = e.type;
        if (ve(t)) return bs(e, t, n)
    }
    return n
}

function nf(e, n, t, r, l, i, o, u, a) {
    return e = du(t, r, !0, e, l, i, o, u, a), e.context = ef(null), t = e.current, r = ce(), l = vn(t), i = Xe(r, l), i.callback = n ?? null, mn(t, i, l), e.current.lanes = l, dr(e, l, r), ge(e, r), e
}

function Al(e, n, t, r) {
    var l = n.current,
        i = ce(),
        o = vn(l);
    return t = ef(t), n.context === null ? n.context = t : n.pendingContext = t, n = Xe(i, o), n.payload = {
        element: e
    }, r = r === void 0 ? null : r, r !== null && (n.callback = r), e = mn(l, n, o), e !== null && (Me(e, l, o, i), Zr(e, l, o)), o
}

function El(e) {
    if (e = e.current, !e.child) return null;
    switch (e.child.tag) {
        case 5:
            return e.child.stateNode;
        default:
            return e.child.stateNode
    }
}

function ja(e, n) {
    if (e = e.memoizedState, e !== null && e.dehydrated !== null) {
        var t = e.retryLane;
        e.retryLane = t !== 0 && t < n ? t : n
    }
}

function pu(e, n) {
    ja(e, n), (e = e.alternate) && ja(e, n)
}

function U1() {
    return null
}
var tf = typeof reportError == "function" ? reportError : function(e) {
    console.error(e)
};

function mu(e) {
    this._internalRoot = e
}
Ul.prototype.render = mu.prototype.render = function(e) {
    var n = this._internalRoot;
    if (n === null) throw Error(k(409));
    Al(e, n, null, null)
};
Ul.prototype.unmount = mu.prototype.unmount = function() {
    var e = this._internalRoot;
    if (e !== null) {
        this._internalRoot = null;
        var n = e.containerInfo;
        Un(function() {
            Al(null, e, null, null)
        }), n[Je] = null
    }
};

function Ul(e) {
    this._internalRoot = e
}
Ul.prototype.unstable_scheduleHydration = function(e) {
    if (e) {
        var n = zs();
        e = {
            blockedOn: null,
            target: e,
            priority: n
        };
        for (var t = 0; t < on.length && n !== 0 && n < on[t].priority; t++);
        on.splice(t, 0, e), t === 0 && Rs(e)
    }
};

function hu(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}

function $l(e) {
    return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}

function La() {}

function $1(e, n, t, r, l) {
    if (l) {
        if (typeof r == "function") {
            var i = r;
            r = function() {
                var s = El(o);
                i.call(s)
            }
        }
        var o = nf(n, r, e, 0, null, !1, !1, "", La);
        return e._reactRootContainer = o, e[Je] = o.current, tr(e.nodeType === 8 ? e.parentNode : e), Un(), o
    }
    for (; l = e.lastChild;) e.removeChild(l);
    if (typeof r == "function") {
        var u = r;
        r = function() {
            var s = El(a);
            u.call(s)
        }
    }
    var a = du(e, 0, !1, null, null, !1, !1, "", La);
    return e._reactRootContainer = a, e[Je] = a.current, tr(e.nodeType === 8 ? e.parentNode : e), Un(function() {
        Al(n, a, t, r)
    }), a
}

function Bl(e, n, t, r, l) {
    var i = t._reactRootContainer;
    if (i) {
        var o = i;
        if (typeof l == "function") {
            var u = l;
            l = function() {
                var a = El(o);
                u.call(a)
            }
        }
        Al(n, o, e, l)
    } else o = $1(t, n, e, l, r);
    return El(o)
}
Ps = function(e) {
    switch (e.tag) {
        case 3:
            var n = e.stateNode;
            if (n.current.memoizedState.isDehydrated) {
                var t = Mt(n.pendingLanes);
                t !== 0 && (Ro(n, t | 1), ge(n, Z()), !(I & 6) && (yt = Z() + 500, kn()))
            }
            break;
        case 13:
            Un(function() {
                var r = qe(e, 1);
                if (r !== null) {
                    var l = ce();
                    Me(r, e, 1, l)
                }
            }), pu(e, 1)
    }
};
Io = function(e) {
    if (e.tag === 13) {
        var n = qe(e, 134217728);
        if (n !== null) {
            var t = ce();
            Me(n, e, 134217728, t)
        }
        pu(e, 134217728)
    }
};
Ds = function(e) {
    if (e.tag === 13) {
        var n = vn(e),
            t = qe(e, n);
        if (t !== null) {
            var r = ce();
            Me(t, e, n, r)
        }
        pu(e, n)
    }
};
zs = function() {
    return M
};
Os = function(e, n) {
    var t = M;
    try {
        return M = e, n()
    } finally {
        M = t
    }
};
Ai = function(e, n, t) {
    switch (n) {
        case "input":
            if (Di(e, t), n = t.name, t.type === "radio" && n != null) {
                for (t = e; t.parentNode;) t = t.parentNode;
                for (t = t.querySelectorAll("input[name=" + JSON.stringify("" + n) + '][type="radio"]'), n = 0; n < t.length; n++) {
                    var r = t[n];
                    if (r !== e && r.form === e.form) {
                        var l = Dl(r);
                        if (!l) throw Error(k(90));
                        cs(r), Di(r, l)
                    }
                }
            }
            break;
        case "textarea":
            ds(e, t);
            break;
        case "select":
            n = t.value, n != null && ot(e, !!t.multiple, n, !1)
    }
};
xs = au;
ws = Un;
var B1 = {
        usingClientEntryPoint: !1,
        Events: [mr, qn, Dl, gs, ys, au]
    },
    Pt = {
        findFiberByHostInstance: Tn,
        bundleType: 0,
        version: "18.2.0",
        rendererPackageName: "react-dom"
    },
    H1 = {
        bundleType: Pt.bundleType,
        version: Pt.version,
        rendererPackageName: Pt.rendererPackageName,
        rendererConfig: Pt.rendererConfig,
        overrideHookState: null,
        overrideHookStateDeletePath: null,
        overrideHookStateRenamePath: null,
        overrideProps: null,
        overridePropsDeletePath: null,
        overridePropsRenamePath: null,
        setErrorHandler: null,
        setSuspenseHandler: null,
        scheduleUpdate: null,
        currentDispatcherRef: en.ReactCurrentDispatcher,
        findHostInstanceByFiber: function(e) {
            return e = Ss(e), e === null ? null : e.stateNode
        },
        findFiberByHostInstance: Pt.findFiberByHostInstance || U1,
        findHostInstancesForRefresh: null,
        scheduleRefresh: null,
        scheduleRoot: null,
        setRefreshHandler: null,
        getCurrentFiber: null,
        reconcilerVersion: "18.2.0-next-9e3b772b8-20220608"
    };
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ < "u") {
    var Mr = __REACT_DEVTOOLS_GLOBAL_HOOK__;
    if (!Mr.isDisabled && Mr.supportsFiber) try {
        jl = Mr.inject(H1), Be = Mr
    } catch {}
}
ke.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = B1;
ke.createPortal = function(e, n) {
    var t = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
    if (!hu(n)) throw Error(k(200));
    return A1(e, n, null, t)
};
ke.createRoot = function(e, n) {
    if (!hu(e)) throw Error(k(299));
    var t = !1,
        r = "",
        l = tf;
    return n != null && (n.unstable_strictMode === !0 && (t = !0), n.identifierPrefix !== void 0 && (r = n.identifierPrefix), n.onRecoverableError !== void 0 && (l = n.onRecoverableError)), n = du(e, 1, !1, null, null, t, !1, r, l), e[Je] = n.current, tr(e.nodeType === 8 ? e.parentNode : e), new mu(n)
};
ke.findDOMNode = function(e) {
    if (e == null) return null;
    if (e.nodeType === 1) return e;
    var n = e._reactInternals;
    if (n === void 0) throw typeof e.render == "function" ? Error(k(188)) : (e = Object.keys(e).join(","), Error(k(268, e)));
    return e = Ss(n), e = e === null ? null : e.stateNode, e
};
ke.flushSync = function(e) {
    return Un(e)
};
ke.hydrate = function(e, n, t) {
    if (!$l(n)) throw Error(k(200));
    return Bl(null, e, n, !0, t)
};
ke.hydrateRoot = function(e, n, t) {
    if (!hu(e)) throw Error(k(405));
    var r = t != null && t.hydratedSources || null,
        l = !1,
        i = "",
        o = tf;
    if (t != null && (t.unstable_strictMode === !0 && (l = !0), t.identifierPrefix !== void 0 && (i = t.identifierPrefix), t.onRecoverableError !== void 0 && (o = t.onRecoverableError)), n = nf(n, null, e, 1, t ?? null, l, !1, i, o), e[Je] = n.current, tr(e), r)
        for (e = 0; e < r.length; e++) t = r[e], l = t._getVersion, l = l(t._source), n.mutableSourceEagerHydrationData == null ? n.mutableSourceEagerHydrationData = [t, l] : n.mutableSourceEagerHydrationData.push(t, l);
    return new Ul(n)
};
ke.render = function(e, n, t) {
    if (!$l(n)) throw Error(k(200));
    return Bl(null, e, n, !1, t)
};
ke.unmountComponentAtNode = function(e) {
    if (!$l(e)) throw Error(k(40));
    return e._reactRootContainer ? (Un(function() {
        Bl(null, null, e, !1, function() {
            e._reactRootContainer = null, e[Je] = null
        })
    }), !0) : !1
};
ke.unstable_batchedUpdates = au;
ke.unstable_renderSubtreeIntoContainer = function(e, n, t, r) {
    if (!$l(t)) throw Error(k(200));
    if (e == null || e._reactInternals === void 0) throw Error(k(38));
    return Bl(e, n, t, !1, r)
};
ke.version = "18.2.0-next-9e3b772b8-20220608";

function rf() {
    if (!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ > "u" || typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function")) try {
        __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(rf)
    } catch (e) {
        console.error(e)
    }
}
rf(), ns.exports = ke;
var lf = ns.exports,
    Ta = lf;
Ei.createRoot = Ta.createRoot, Ei.hydrateRoot = Ta.hydrateRoot;

function of(e) {
    var n, t, r = "";
    if (typeof e == "string" || typeof e == "number") r += e;
    else if (typeof e == "object")
        if (Array.isArray(e))
            for (n = 0; n < e.length; n++) e[n] && (t = of(e[n])) && (r && (r += " "), r += t);
        else
            for (n in e) e[n] && (r && (r += " "), r += n);
    return r
}

function Hn() {
    for (var e, n, t = 0, r = ""; t < arguments.length;)(e = arguments[t++]) && (n = of(e)) && (r && (r += " "), r += n);
    return r
}
let V1 = {
        data: ""
    },
    W1 = e => typeof window == "object" ? ((e ? e.querySelector("#_goober") : window._goober) || Object.assign((e || document.head).appendChild(document.createElement("style")), {
        innerHTML: " ",
        id: "_goober"
    })).firstChild : e || V1,
    Q1 = /(?:([\u0080-\uFFFF\w-%@]+) *:? *([^{;]+?);|([^;}{]*?) *{)|(}\s*)/g,
    K1 = /\/\*[^]*?\*\/|  +/g,
    Pa = /\n+/g,
    Ln = (e, n) => {
        let t = "",
            r = "",
            l = "";
        for (let i in e) {
            let o = e[i];
            i[0] == "@" ? i[1] == "i" ? t = i + " " + o + ";" : r += i[1] == "f" ? Ln(o, i) : i + "{" + Ln(o, i[1] == "k" ? "" : n) + "}" : typeof o == "object" ? r += Ln(o, n ? n.replace(/([^,])+/g, u => i.replace(/(^:.*)|([^,])+/g, a => /&/.test(a) ? a.replace(/&/g, u) : u ? u + " " + a : a)) : i) : o != null && (i = /^--/.test(i) ? i : i.replace(/[A-Z]/g, "-$&").toLowerCase(), l += Ln.p ? Ln.p(i, o) : i + ":" + o + ";")
        }
        return t + (n && l ? n + "{" + l + "}" : l) + r
    },
    Ve = {},
    uf = e => {
        if (typeof e == "object") {
            let n = "";
            for (let t in e) n += t + uf(e[t]);
            return n
        }
        return e
    },
    G1 = (e, n, t, r, l) => {
        let i = uf(e),
            o = Ve[i] || (Ve[i] = (a => {
                let s = 0,
                    m = 11;
                for (; s < a.length;) m = 101 * m + a.charCodeAt(s++) >>> 0;
                return "go" + m
            })(i));
        if (!Ve[o]) {
            let a = i !== e ? e : (s => {
                let m, v, h = [{}];
                for (; m = Q1.exec(s.replace(K1, ""));) m[4] ? h.shift() : m[3] ? (v = m[3].replace(Pa, " ").trim(), h.unshift(h[0][v] = h[0][v] || {})) : h[0][m[1]] = m[2].replace(Pa, " ").trim();
                return h[0]
            })(e);
            Ve[o] = Ln(l ? {
                ["@keyframes " + o]: a
            } : a, t ? "" : "." + o)
        }
        let u = t && Ve.g ? Ve.g : null;
        return t && (Ve.g = Ve[o]), ((a, s, m, v) => {
            v ? s.data = s.data.replace(v, a) : s.data.indexOf(a) === -1 && (s.data = m ? a + s.data : s.data + a)
        })(Ve[o], n, r, u), o
    },
    Z1 = (e, n, t) => e.reduce((r, l, i) => {
        let o = n[i];
        if (o && o.call) {
            let u = o(t),
                a = u && u.props && u.props.className || /^go/.test(u) && u;
            o = a ? "." + a : u && typeof u == "object" ? u.props ? "" : Ln(u, "") : u === !1 ? "" : u
        }
        return r + l + (o ?? "")
    }, "");

function vu(e) {
    let n = this || {},
        t = e.call ? e(n.p) : e;
    return G1(t.unshift ? t.raw ? Z1(t, [].slice.call(arguments, 1), n.p) : t.reduce((r, l) => Object.assign(r, l && l.call ? l(n.p) : l), {}) : t, W1(n.target), n.g, n.o, n.k)
}
vu.bind({
    g: 1
});
vu.bind({
    k: 1
});

function Da(e, n) {
    for (var t = 0; t < n.length; t++) {
        var r = n[t];
        r.enumerable = r.enumerable || !1, r.configurable = !0, "value" in r && (r.writable = !0), Object.defineProperty(e, r.key, r)
    }
}

function af(e, n, t) {
    return n && Da(e.prototype, n), t && Da(e, t), e
}

function F() {
    return F = Object.assign || function(e) {
        for (var n = 1; n < arguments.length; n++) {
            var t = arguments[n];
            for (var r in t) Object.prototype.hasOwnProperty.call(t, r) && (e[r] = t[r])
        }
        return e
    }, F.apply(this, arguments)
}

function sf(e, n) {
    e.prototype = Object.create(n.prototype), e.prototype.constructor = e, e.__proto__ = n
}

function vr(e, n) {
    if (e == null) return {};
    var t = {},
        r = Object.keys(e),
        l, i;
    for (i = 0; i < r.length; i++) l = r[i], !(n.indexOf(l) >= 0) && (t[l] = e[l]);
    return t
}

function za(e) {
    if (e === void 0) throw new ReferenceError("this hasn't been initialised - super() hasn't been called");
    return e
}
var Oa = function() {
        return ""
    },
    cf = A.createContext({
        enqueueSnackbar: Oa,
        closeSnackbar: Oa
    }),
    jn = {
        downXs: "@media (max-width:599.95px)",
        upSm: "@media (min-width:600px)"
    },
    Ra = function(n) {
        return n.charAt(0).toUpperCase() + n.slice(1)
    },
    gu = function(n) {
        return "" + Ra(n.vertical) + Ra(n.horizontal)
    },
    Fr = function(n) {
        return !!n || n === 0
    },
    Ar = "unmounted",
    Wn = "exited",
    Qn = "entering",
    Dt = "entered",
    Ia = "exiting",
    yu = function(e) {
        sf(n, e);

        function n(r) {
            var l;
            l = e.call(this, r) || this;
            var i = r.appear,
                o;
            return l.appearStatus = null, r.in ? i ? (o = Wn, l.appearStatus = Qn) : o = Dt : r.unmountOnExit || r.mountOnEnter ? o = Ar : o = Wn, l.state = {
                status: o
            }, l.nextCallback = null, l
        }
        n.getDerivedStateFromProps = function(l, i) {
            var o = l.in;
            return o && i.status === Ar ? {
                status: Wn
            } : null
        };
        var t = n.prototype;
        return t.componentDidMount = function() {
            this.updateStatus(!0, this.appearStatus)
        }, t.componentDidUpdate = function(l) {
            var i = null;
            if (l !== this.props) {
                var o = this.state.status;
                this.props.in ? o !== Qn && o !== Dt && (i = Qn) : (o === Qn || o === Dt) && (i = Ia)
            }
            this.updateStatus(!1, i)
        }, t.componentWillUnmount = function() {
            this.cancelNextCallback()
        }, t.getTimeouts = function() {
            var l = this.props.timeout,
                i = l,
                o = l;
            return l != null && typeof l != "number" && typeof l != "string" && (o = l.exit, i = l.enter), {
                exit: o,
                enter: i
            }
        }, t.updateStatus = function(l, i) {
            l === void 0 && (l = !1), i !== null ? (this.cancelNextCallback(), i === Qn ? this.performEnter(l) : this.performExit()) : this.props.unmountOnExit && this.state.status === Wn && this.setState({
                status: Ar
            })
        }, t.performEnter = function(l) {
            var i = this,
                o = this.props.enter,
                u = l,
                a = this.getTimeouts();
            if (!l && !o) {
                this.safeSetState({
                    status: Dt
                }, function() {
                    i.props.onEntered && i.props.onEntered(i.node, u)
                });
                return
            }
            this.props.onEnter && this.props.onEnter(this.node, u), this.safeSetState({
                status: Qn
            }, function() {
                i.props.onEntering && i.props.onEntering(i.node, u), i.onTransitionEnd(a.enter, function() {
                    i.safeSetState({
                        status: Dt
                    }, function() {
                        i.props.onEntered && i.props.onEntered(i.node, u)
                    })
                })
            })
        }, t.performExit = function() {
            var l = this,
                i = this.props.exit,
                o = this.getTimeouts();
            if (!i) {
                this.safeSetState({
                    status: Wn
                }, function() {
                    l.props.onExited && l.props.onExited(l.node)
                });
                return
            }
            this.props.onExit && this.props.onExit(this.node), this.safeSetState({
                status: Ia
            }, function() {
                l.props.onExiting && l.props.onExiting(l.node), l.onTransitionEnd(o.exit, function() {
                    l.safeSetState({
                        status: Wn
                    }, function() {
                        l.props.onExited && l.props.onExited(l.node)
                    })
                })
            })
        }, t.cancelNextCallback = function() {
            this.nextCallback !== null && this.nextCallback.cancel && (this.nextCallback.cancel(), this.nextCallback = null)
        }, t.safeSetState = function(l, i) {
            i = this.setNextCallback(i), this.setState(l, i)
        }, t.setNextCallback = function(l) {
            var i = this,
                o = !0;
            return this.nextCallback = function() {
                o && (o = !1, i.nextCallback = null, l())
            }, this.nextCallback.cancel = function() {
                o = !1
            }, this.nextCallback
        }, t.onTransitionEnd = function(l, i) {
            this.setNextCallback(i);
            var o = l == null && !this.props.addEndListener;
            if (!this.node || o) {
                setTimeout(this.nextCallback, 0);
                return
            }
            this.props.addEndListener && this.props.addEndListener(this.node, this.nextCallback), l != null && setTimeout(this.nextCallback, l)
        }, t.render = function() {
            var l = this.state.status;
            if (l === Ar) return null;
            var i = this.props,
                o = i.children,
                u = vr(i, ["children", "in", "mountOnEnter", "unmountOnExit", "appear", "enter", "exit", "timeout", "addEndListener", "onEnter", "onEntering", "onEntered", "onExit", "onExiting", "onExited", "nodeRef"]);
            return o(l, u)
        }, af(n, [{
            key: "node",
            get: function() {
                var l, i = (l = this.props.nodeRef) === null || l === void 0 ? void 0 : l.current;
                if (!i) throw new Error("notistack - Custom snackbar is not refForwarding");
                return i
            }
        }]), n
    }(A.Component);

function Kn() {}
yu.defaultProps = {
    in: !1,
    mountOnEnter: !1,
    unmountOnExit: !1,
    appear: !1,
    enter: !0,
    exit: !0,
    onEnter: Kn,
    onEntering: Kn,
    onEntered: Kn,
    onExit: Kn,
    onExiting: Kn,
    onExited: Kn
};

function Ma(e, n) {
    typeof e == "function" ? e(n) : e && (e.current = n)
}

function yo(e, n) {
    return T.useMemo(function() {
        return e == null && n == null ? null : function(t) {
            Ma(e, t), Ma(n, t)
        }
    }, [e, n])
}

function _l(e) {
    var n = e.timeout,
        t = e.style,
        r = t === void 0 ? {} : t,
        l = e.mode;
    return {
        duration: typeof n == "object" ? n[l] || 0 : n,
        easing: r.transitionTimingFunction,
        delay: r.transitionDelay
    }
}
var xo = {
        easeInOut: "cubic-bezier(0.4, 0, 0.2, 1)",
        easeOut: "cubic-bezier(0.0, 0, 0.2, 1)",
        easeIn: "cubic-bezier(0.4, 0, 1, 1)",
        sharp: "cubic-bezier(0.4, 0, 0.6, 1)"
    },
    ff = function(n) {
        n.scrollTop = n.scrollTop
    },
    Fa = function(n) {
        return Math.round(n) + "ms"
    };

function it(e, n) {
    e === void 0 && (e = ["all"]);
    var t = n || {},
        r = t.duration,
        l = r === void 0 ? 300 : r,
        i = t.easing,
        o = i === void 0 ? xo.easeInOut : i,
        u = t.delay,
        a = u === void 0 ? 0 : u,
        s = Array.isArray(e) ? e : [e];
    return s.map(function(m) {
        var v = typeof l == "string" ? l : Fa(l),
            h = typeof a == "string" ? a : Fa(a);
        return m + " " + v + " " + o + " " + h
    }).join(",")
}

function X1(e) {
    return e && e.ownerDocument || document
}

function df(e) {
    var n = X1(e);
    return n.defaultView || window
}

function Y1(e, n) {
    n === void 0 && (n = 166);
    var t;

    function r() {
        for (var l = this, i = arguments.length, o = new Array(i), u = 0; u < i; u++) o[u] = arguments[u];
        var a = function() {
            e.apply(l, o)
        };
        clearTimeout(t), t = setTimeout(a, n)
    }
    return r.clear = function() {
        clearTimeout(t)
    }, r
}

function J1(e, n) {
    var t = n.getBoundingClientRect(),
        r = df(n),
        l;
    if (n.fakeTransform) l = n.fakeTransform;
    else {
        var i = r.getComputedStyle(n);
        l = i.getPropertyValue("-webkit-transform") || i.getPropertyValue("transform")
    }
    var o = 0,
        u = 0;
    if (l && l !== "none" && typeof l == "string") {
        var a = l.split("(")[1].split(")")[0].split(",");
        o = parseInt(a[4], 10), u = parseInt(a[5], 10)
    }
    switch (e) {
        case "left":
            return "translateX(" + (r.innerWidth + o - t.left) + "px)";
        case "right":
            return "translateX(-" + (t.left + t.width - o) + "px)";
        case "up":
            return "translateY(" + (r.innerHeight + u - t.top) + "px)";
        default:
            return "translateY(-" + (t.top + t.height - u) + "px)"
    }
}

function Ur(e, n) {
    if (n) {
        var t = J1(e, n);
        t && (n.style.webkitTransform = t, n.style.transform = t)
    }
}
var pf = T.forwardRef(function(e, n) {
    var t = e.children,
        r = e.direction,
        l = r === void 0 ? "down" : r,
        i = e.in,
        o = e.style,
        u = e.timeout,
        a = u === void 0 ? 0 : u,
        s = e.onEnter,
        m = e.onEntered,
        v = e.onExit,
        h = e.onExited,
        C = vr(e, ["children", "direction", "in", "style", "timeout", "onEnter", "onEntered", "onExit", "onExited"]),
        g = T.useRef(null),
        x = yo(t.ref, g),
        L = yo(x, n),
        f = function(w, _) {
            Ur(l, w), ff(w), s && s(w, _)
        },
        c = function(w) {
            var _ = (o == null ? void 0 : o.transitionTimingFunction) || xo.easeOut,
                R = _l({
                    timeout: a,
                    mode: "enter",
                    style: F({}, o, {
                        transitionTimingFunction: _
                    })
                });
            w.style.webkitTransition = it("-webkit-transform", R), w.style.transition = it("transform", R), w.style.webkitTransform = "none", w.style.transform = "none"
        },
        d = function(w) {
            var _ = (o == null ? void 0 : o.transitionTimingFunction) || xo.sharp,
                R = _l({
                    timeout: a,
                    mode: "exit",
                    style: F({}, o, {
                        transitionTimingFunction: _
                    })
                });
            w.style.webkitTransition = it("-webkit-transform", R), w.style.transition = it("transform", R), Ur(l, w), v && v(w)
        },
        y = function(w) {
            w.style.webkitTransition = "", w.style.transition = "", h && h(w)
        },
        S = T.useCallback(function() {
            g.current && Ur(l, g.current)
        }, [l]);
    return T.useEffect(function() {
        if (!(i || l === "down" || l === "right")) {
            var E = Y1(function() {
                    g.current && Ur(l, g.current)
                }),
                w = df(g.current);
            return w.addEventListener("resize", E),
                function() {
                    E.clear(), w.removeEventListener("resize", E)
                }
        }
    }, [l, i]), T.useEffect(function() {
        i || S()
    }, [i, S]), T.createElement(yu, Object.assign({
        appear: !0,
        nodeRef: g,
        onEnter: f,
        onEntered: m,
        onEntering: c,
        onExit: d,
        onExited: y,
        in: i,
        timeout: a
    }, C), function(E, w) {
        return T.cloneElement(t, F({
            ref: L,
            style: F({
                visibility: E === "exited" && !i ? "hidden" : void 0
            }, o, {}, t.props.style)
        }, w))
    })
});
pf.displayName = "Slide";
var Hl = function(n) {
        return A.createElement("svg", Object.assign({
            viewBox: "0 0 24 24",
            focusable: "false",
            style: {
                fontSize: 20,
                marginInlineEnd: 8,
                userSelect: "none",
                width: "1em",
                height: "1em",
                display: "inline-block",
                fill: "currentColor",
                flexShrink: 0
            }
        }, n))
    },
    q1 = function() {
        return A.createElement(Hl, null, A.createElement("path", {
            d: `M12 2C6.5 2 2 6.5 2 12S6.5 22 12 22 22 17.5 22 12 17.5 2 12 2M10 17L5 12L6.41
        10.59L10 14.17L17.59 6.58L19 8L10 17Z`
        }))
    },
    b1 = function() {
        return A.createElement(Hl, null, A.createElement("path", {
            d: "M13,14H11V10H13M13,18H11V16H13M1,21H23L12,2L1,21Z"
        }))
    },
    ep = function() {
        return A.createElement(Hl, null, A.createElement("path", {
            d: `M12,2C17.53,2 22,6.47 22,12C22,17.53 17.53,22 12,22C6.47,22 2,17.53 2,12C2,
        6.47 6.47,2 12,2M15.59,7L12,10.59L8.41,7L7,8.41L10.59,12L7,15.59L8.41,17L12,
        13.41L15.59,17L17,15.59L13.41,12L17,8.41L15.59,7Z`
        }))
    },
    np = function() {
        return A.createElement(Hl, null, A.createElement("path", {
            d: `M13,9H11V7H13M13,17H11V11H13M12,2A10,10 0 0,0 2,12A10,10 0 0,0 12,22A10,10 0 0,
        0 22,12A10,10 0 0,0 12,2Z`
        }))
    },
    tp = {
        default: void 0,
        success: A.createElement(q1, null),
        warning: A.createElement(b1, null),
        error: A.createElement(ep, null),
        info: A.createElement(np, null)
    },
    Rn = {
        maxSnack: 3,
        persist: !1,
        hideIconVariant: !1,
        disableWindowBlurListener: !1,
        variant: "default",
        autoHideDuration: 5e3,
        iconVariant: tp,
        anchorOrigin: {
            vertical: "bottom",
            horizontal: "left"
        },
        TransitionComponent: pf,
        transitionDuration: {
            enter: 225,
            exit: 195
        }
    },
    rp = function(n, t) {
        var r = function(i) {
            return typeof i == "number" || i === null
        };
        return r(n) ? n : r(t) ? t : Rn.autoHideDuration
    },
    lp = function(n, t) {
        var r = function(i, o) {
            return o.some(function(u) {
                return typeof i === u
            })
        };
        return r(n, ["string", "number"]) ? n : r(n, ["object"]) ? F({}, Rn.transitionDuration, {}, r(t, ["object"]) && t, {}, n) : r(t, ["string", "number"]) ? t : r(t, ["object"]) ? F({}, Rn.transitionDuration, {}, t) : Rn.transitionDuration
    },
    ip = function(n, t) {
        return function(r, l) {
            return l === void 0 && (l = !1), l ? F({}, Rn[r], {}, t[r], {}, n[r]) : r === "autoHideDuration" ? rp(n.autoHideDuration, t.autoHideDuration) : r === "transitionDuration" ? lp(n.transitionDuration, t.transitionDuration) : n[r] || t[r] || Rn[r]
        }
    };

function gr(e) {
    return Object.entries(e).reduce(function(n, t) {
        var r, l = t[0],
            i = t[1];
        return F({}, n, (r = {}, r[l] = vu(i), r))
    }, {})
}
var xt = {
        SnackbarContainer: "notistack-SnackbarContainer",
        Snackbar: "notistack-Snackbar",
        CollapseWrapper: "notistack-CollapseWrapper",
        MuiContent: "notistack-MuiContent",
        MuiContentVariant: function(n) {
            return "notistack-MuiContent-" + n
        }
    },
    Aa = gr({
        root: {
            height: 0
        },
        entered: {
            height: "auto"
        }
    }),
    yi = "0px",
    xi = 175,
    mf = T.forwardRef(function(e, n) {
        var t = e.children,
            r = e.in,
            l = e.onExited,
            i = T.useRef(null),
            o = T.useRef(null),
            u = yo(n, o),
            a = function() {
                return i.current ? i.current.clientHeight : 0
            },
            s = function(x) {
                x.style.height = yi
            },
            m = function(x) {
                var L = a(),
                    f = _l({
                        timeout: xi,
                        mode: "enter"
                    }),
                    c = f.duration,
                    d = f.easing;
                x.style.transitionDuration = typeof c == "string" ? c : c + "ms", x.style.height = L + "px", x.style.transitionTimingFunction = d || ""
            },
            v = function(x) {
                x.style.height = "auto"
            },
            h = function(x) {
                x.style.height = a() + "px"
            },
            C = function(x) {
                ff(x);
                var L = _l({
                        timeout: xi,
                        mode: "exit"
                    }),
                    f = L.duration,
                    c = L.easing;
                x.style.transitionDuration = typeof f == "string" ? f : f + "ms", x.style.height = yi, x.style.transitionTimingFunction = c || ""
            };
        return T.createElement(yu, {
            in: r,
            unmountOnExit: !0,
            onEnter: s,
            onEntered: v,
            onEntering: m,
            onExit: h,
            onExited: l,
            onExiting: C,
            nodeRef: o,
            timeout: xi
        }, function(g, x) {
            return T.createElement("div", Object.assign({
                ref: u,
                className: Hn(Aa.root, g === "entered" && Aa.entered),
                style: F({
                    pointerEvents: "all",
                    overflow: "hidden",
                    minHeight: yi,
                    transition: it("height")
                }, g === "entered" && {
                    overflow: "visible"
                }, {}, g === "exited" && !r && {
                    visibility: "hidden"
                })
            }, x), T.createElement("div", {
                ref: i,
                className: xt.CollapseWrapper,
                style: {
                    display: "flex",
                    width: "100%"
                }
            }, t))
        })
    });
mf.displayName = "Collapse";
var Ua = {
        right: "left",
        left: "right",
        bottom: "up",
        top: "down"
    },
    op = function(n) {
        return n.horizontal !== "center" ? Ua[n.horizontal] : Ua[n.vertical]
    },
    up = function(n) {
        return "anchorOrigin" + gu(n)
    },
    ap = function(n) {
        n === void 0 && (n = {});
        var t = {
            containerRoot: !0,
            containerAnchorOriginTopCenter: !0,
            containerAnchorOriginBottomCenter: !0,
            containerAnchorOriginTopRight: !0,
            containerAnchorOriginBottomRight: !0,
            containerAnchorOriginTopLeft: !0,
            containerAnchorOriginBottomLeft: !0
        };
        return Object.keys(n).filter(function(r) {
            return !t[r]
        }).reduce(function(r, l) {
            var i;
            return F({}, r, (i = {}, i[l] = n[l], i))
        }, {})
    },
    sp = function() {};

function Gt(e, n) {
    return e.reduce(function(t, r) {
        return r == null ? t : function() {
            for (var i = arguments.length, o = new Array(i), u = 0; u < i; u++) o[u] = arguments[u];
            var a = [].concat(o);
            n && a.indexOf(n) === -1 && a.push(n), t.apply(this, a), r.apply(this, a)
        }
    }, sp)
}
var cp = typeof window < "u" ? T.useLayoutEffect : T.useEffect;

function $a(e) {
    var n = T.useRef(e);
    return cp(function() {
        n.current = e
    }), T.useCallback(function() {
        return n.current.apply(void 0, arguments)
    }, [])
}
var hf = T.forwardRef(function(e, n) {
    var t = e.children,
        r = e.className,
        l = e.autoHideDuration,
        i = e.disableWindowBlurListener,
        o = i === void 0 ? !1 : i,
        u = e.onClose,
        a = e.id,
        s = e.open,
        m = e.SnackbarProps,
        v = m === void 0 ? {} : m,
        h = T.useRef(),
        C = $a(function() {
            u && u.apply(void 0, arguments)
        }),
        g = $a(function(d) {
            !u || d == null || (h.current && clearTimeout(h.current), h.current = setTimeout(function() {
                C(null, "timeout", a)
            }, d))
        });
    T.useEffect(function() {
        return s && g(l),
            function() {
                h.current && clearTimeout(h.current)
            }
    }, [s, l, g]);
    var x = function() {
            h.current && clearTimeout(h.current)
        },
        L = T.useCallback(function() {
            l != null && g(l * .5)
        }, [l, g]),
        f = function(y) {
            v.onMouseEnter && v.onMouseEnter(y), x()
        },
        c = function(y) {
            v.onMouseLeave && v.onMouseLeave(y), L()
        };
    return T.useEffect(function() {
        if (!o && s) return window.addEventListener("focus", L), window.addEventListener("blur", x),
            function() {
                window.removeEventListener("focus", L), window.removeEventListener("blur", x)
            }
    }, [o, L, s]), T.createElement("div", Object.assign({
        ref: n
    }, v, {
        className: Hn(xt.Snackbar, r),
        onMouseEnter: f,
        onMouseLeave: c
    }), t)
});
hf.displayName = "Snackbar";
var wi, fp = gr({
        root: (wi = {
            display: "flex",
            flexWrap: "wrap",
            flexGrow: 1
        }, wi[jn.upSm] = {
            flexGrow: "initial",
            minWidth: "288px"
        }, wi)
    }),
    xu = T.forwardRef(function(e, n) {
        var t = e.className,
            r = vr(e, ["className"]);
        return A.createElement("div", Object.assign({
            ref: n,
            className: Hn(fp.root, t)
        }, r))
    });
xu.displayName = "SnackbarContent";
var zt = gr({
        root: {
            backgroundColor: "#313131",
            fontSize: "0.875rem",
            lineHeight: 1.43,
            letterSpacing: "0.01071em",
            color: "#fff",
            alignItems: "center",
            padding: "6px 16px",
            borderRadius: "4px",
            boxShadow: "0px 3px 5px -1px rgba(0,0,0,0.2),0px 6px 10px 0px rgba(0,0,0,0.14),0px 1px 18px 0px rgba(0,0,0,0.12)"
        },
        lessPadding: {
            paddingLeft: 8 * 2.5 + "px"
        },
        default: {
            backgroundColor: "#313131"
        },
        success: {
            backgroundColor: "#43a047"
        },
        error: {
            backgroundColor: "#d32f2f"
        },
        warning: {
            backgroundColor: "#ff9800"
        },
        info: {
            backgroundColor: "#2196f3"
        },
        message: {
            display: "flex",
            alignItems: "center",
            padding: "8px 0"
        },
        action: {
            display: "flex",
            alignItems: "center",
            marginLeft: "auto",
            paddingLeft: "16px",
            marginRight: "-8px"
        }
    }),
    Ba = "notistack-snackbar",
    vf = T.forwardRef(function(e, n) {
        var t = e.id,
            r = e.message,
            l = e.action,
            i = e.iconVariant,
            o = e.variant,
            u = e.hideIconVariant,
            a = e.style,
            s = e.className,
            m = i[o],
            v = l;
        return typeof v == "function" && (v = v(t)), A.createElement(xu, {
            ref: n,
            role: "alert",
            "aria-describedby": Ba,
            style: a,
            className: Hn(xt.MuiContent, xt.MuiContentVariant(o), zt.root, zt[o], s, !u && m && zt.lessPadding)
        }, A.createElement("div", {
            id: Ba,
            className: zt.message
        }, u ? null : m, r), v && A.createElement("div", {
            className: zt.action
        }, v))
    });
vf.displayName = "MaterialDesignContent";
var dp = T.memo(vf),
    pp = gr({
        wrappedRoot: {
            width: "100%",
            position: "relative",
            transform: "translateX(0)",
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            minWidth: "288px"
        }
    }),
    mp = function(n) {
        var t = T.useRef(),
            r = T.useState(!0),
            l = r[0],
            i = r[1],
            o = Gt([n.snack.onClose, n.onClose]),
            u = function() {
                n.snack.requestClose && o(null, "instructed", n.snack.id)
            },
            a = T.useCallback(function() {
                t.current = setTimeout(function() {
                    i(function(R) {
                        return !R
                    })
                }, 125)
            }, []);
        T.useEffect(function() {
            return function() {
                t.current && clearTimeout(t.current)
            }
        }, []);
        var s = n.snack,
            m = n.classes,
            v = n.Component,
            h = v === void 0 ? dp : v,
            C = T.useMemo(function() {
                return ap(m)
            }, [m]),
            g = s.open,
            x = s.SnackbarProps,
            L = s.TransitionComponent,
            f = s.TransitionProps,
            c = s.transitionDuration,
            d = s.disableWindowBlurListener,
            y = s.content,
            S = vr(s, ["open", "SnackbarProps", "TransitionComponent", "TransitionProps", "transitionDuration", "disableWindowBlurListener", "content", "entered", "requestClose", "onEnter", "onEntered", "onExit", "onExited"]),
            E = F({
                direction: op(S.anchorOrigin),
                timeout: c
            }, f),
            w = y;
        typeof w == "function" && (w = w(S.id, S.message));
        var _ = ["onEnter", "onEntered", "onExit", "onExited"].reduce(function(R, P) {
            var q;
            return F({}, R, (q = {}, q[P] = Gt([n.snack[P], n[P]], S.id), q))
        }, {});
        return A.createElement(mf, {
            in: l,
            onExited: _.onExited
        }, A.createElement(hf, {
            open: g,
            id: S.id,
            disableWindowBlurListener: d,
            autoHideDuration: S.autoHideDuration,
            className: Hn(pp.wrappedRoot, C.root, C[up(S.anchorOrigin)]),
            SnackbarProps: x,
            onClose: o
        }, A.createElement(L, Object.assign({}, E, {
            appear: !0,
            in: g,
            onExit: _.onExit,
            onExited: a,
            onEnter: _.onEnter,
            onEntered: Gt([_.onEntered, u], S.id)
        }), w || A.createElement(h, Object.assign({}, S)))))
    },
    Ot, Ci, $r, Br, ki, We = {
        view: {
            default: 20,
            dense: 4
        },
        snackbar: {
            default: 6,
            dense: 2
        }
    },
    Ha = "." + xt.CollapseWrapper,
    Si = 16,
    Hr = gr({
        root: (Ot = {
            boxSizing: "border-box",
            display: "flex",
            maxHeight: "100%",
            position: "fixed",
            zIndex: 1400,
            height: "auto",
            width: "auto",
            transition: it(["top", "right", "bottom", "left", "max-width"], {
                duration: 300,
                easing: "ease"
            }),
            pointerEvents: "none"
        }, Ot[Ha] = {
            padding: We.snackbar.default+"px 0px",
            transition: "padding 300ms ease 0ms"
        }, Ot.maxWidth = "calc(100% - " + We.view.default * 2 + "px)", Ot[jn.downXs] = {
            width: "100%",
            maxWidth: "calc(100% - " + Si * 2 + "px)"
        }, Ot),
        rootDense: (Ci = {}, Ci[Ha] = {
            padding: We.snackbar.dense + "px 0px"
        }, Ci),
        top: {
            top: We.view.default-We.snackbar.default+"px",
            flexDirection: "column"
        },
        bottom: {
            bottom: We.view.default-We.snackbar.default+"px",
            flexDirection: "column-reverse"
        },
        left: ($r = {
            left: We.view.default+"px"
        }, $r[jn.upSm] = {
            alignItems: "flex-start"
        }, $r[jn.downXs] = {
            left: Si + "px"
        }, $r),
        right: (Br = {
            right: We.view.default+"px"
        }, Br[jn.upSm] = {
            alignItems: "flex-end"
        }, Br[jn.downXs] = {
            right: Si + "px"
        }, Br),
        center: (ki = {
            left: "50%",
            transform: "translateX(-50%)"
        }, ki[jn.upSm] = {
            alignItems: "center"
        }, ki)
    }),
    hp = function(n) {
        var t = n.classes,
            r = t === void 0 ? {} : t,
            l = n.anchorOrigin,
            i = n.dense,
            o = n.children,
            u = Hn(xt.SnackbarContainer, Hr[l.vertical], Hr[l.horizontal], Hr.root, r.containerRoot, r["containerAnchorOrigin" + gu(l)], i && Hr.rootDense);
        return A.createElement("div", {
            className: u
        }, o)
    },
    vp = T.memo(hp),
    Va = function(n) {
        var t = typeof n == "string" || T.isValidElement(n);
        return !t
    },
    wo, gp = function(e) {
        sf(n, e);

        function n(r) {
            var l;
            return l = e.call(this, r) || this, l.enqueueSnackbar = function(i, o) {
                if (o === void 0 && (o = {}), i == null) throw new Error("enqueueSnackbar called with invalid argument");
                var u = Va(i) ? i : o,
                    a = Va(i) ? i.message : i,
                    s = u.key,
                    m = u.preventDuplicate,
                    v = vr(u, ["key", "preventDuplicate"]),
                    h = Fr(s),
                    C = h ? s : new Date().getTime() + Math.random(),
                    g = ip(v, l.props),
                    x = F({
                        id: C
                    }, v, {
                        message: a,
                        open: !0,
                        entered: !1,
                        requestClose: !1,
                        persist: g("persist"),
                        action: g("action"),
                        content: g("content"),
                        variant: g("variant"),
                        anchorOrigin: g("anchorOrigin"),
                        disableWindowBlurListener: g("disableWindowBlurListener"),
                        autoHideDuration: g("autoHideDuration"),
                        hideIconVariant: g("hideIconVariant"),
                        TransitionComponent: g("TransitionComponent"),
                        transitionDuration: g("transitionDuration"),
                        TransitionProps: g("TransitionProps", !0),
                        iconVariant: g("iconVariant", !0),
                        style: g("style", !0),
                        SnackbarProps: g("SnackbarProps", !0),
                        className: Hn(l.props.className, v.className)
                    });
                return x.persist && (x.autoHideDuration = void 0), l.setState(function(L) {
                    if (m === void 0 && l.props.preventDuplicate || m) {
                        var f = function(S) {
                                return h ? S.id === C : S.message === a
                            },
                            c = L.queue.findIndex(f) > -1,
                            d = L.snacks.findIndex(f) > -1;
                        if (c || d) return L
                    }
                    return l.handleDisplaySnack(F({}, L, {
                        queue: [].concat(L.queue, [x])
                    }))
                }), C
            }, l.handleDisplaySnack = function(i) {
                var o = i.snacks;
                return o.length >= l.maxSnack ? l.handleDismissOldest(i) : l.processQueue(i)
            }, l.processQueue = function(i) {
                var o = i.queue,
                    u = i.snacks;
                return o.length > 0 ? F({}, i, {
                    snacks: [].concat(u, [o[0]]),
                    queue: o.slice(1, o.length)
                }) : i
            }, l.handleDismissOldest = function(i) {
                if (i.snacks.some(function(m) {
                    return !m.open || m.requestClose
                })) return i;
                var o = !1,
                    u = !1,
                    a = i.snacks.reduce(function(m, v) {
                        return m + (v.open && v.persist ? 1 : 0)
                    }, 0);
                a === l.maxSnack && (u = !0);
                var s = i.snacks.map(function(m) {
                    return !o && (!m.persist || u) ? (o = !0, m.entered ? (m.onClose && m.onClose(null, "maxsnack", m.id), l.props.onClose && l.props.onClose(null, "maxsnack", m.id), F({}, m, {
                        open: !1
                    })) : F({}, m, {
                        requestClose: !0
                    })) : F({}, m)
                });
                return F({}, i, {
                    snacks: s
                })
            }, l.handleEnteredSnack = function(i, o, u) {
                if (!Fr(u)) throw new Error("handleEnteredSnack Cannot be called with undefined key");
                l.setState(function(a) {
                    var s = a.snacks;
                    return {
                        snacks: s.map(function(m) {
                            return m.id === u ? F({}, m, {
                                entered: !0
                            }) : F({}, m)
                        })
                    }
                })
            }, l.handleCloseSnack = function(i, o, u) {
                l.props.onClose && l.props.onClose(i, o, u);
                var a = u === void 0;
                l.setState(function(s) {
                    var m = s.snacks,
                        v = s.queue;
                    return {
                        snacks: m.map(function(h) {
                            return !a && h.id !== u ? F({}, h) : h.entered ? F({}, h, {
                                open: !1
                            }) : F({}, h, {
                                requestClose: !0
                            })
                        }),
                        queue: v.filter(function(h) {
                            return h.id !== u
                        })
                    }
                })
            }, l.closeSnackbar = function(i) {
                var o = l.state.snacks.find(function(u) {
                    return u.id === i
                });
                Fr(i) && o && o.onClose && o.onClose(null, "instructed", i), l.handleCloseSnack(null, "instructed", i)
            }, l.handleExitedSnack = function(i, o) {
                if (!Fr(o)) throw new Error("handleExitedSnack Cannot be called with undefined key");
                l.setState(function(u) {
                    var a = l.processQueue(F({}, u, {
                        snacks: u.snacks.filter(function(s) {
                            return s.id !== o
                        })
                    }));
                    return a.queue.length === 0 ? a : l.handleDismissOldest(a)
                })
            }, wo = l.enqueueSnackbar, l.closeSnackbar, l.state = {
                snacks: [],
                queue: [],
                contextValue: {
                    enqueueSnackbar: l.enqueueSnackbar.bind(za(l)),
                    closeSnackbar: l.closeSnackbar.bind(za(l))
                }
            }, l
        }
        var t = n.prototype;
        return t.render = function() {
            var l = this,
                i = this.state.contextValue,
                o = this.props,
                u = o.domRoot,
                a = o.children,
                s = o.dense,
                m = s === void 0 ? !1 : s,
                v = o.Components,
                h = v === void 0 ? {} : v,
                C = o.classes,
                g = this.state.snacks.reduce(function(L, f) {
                    var c, d = gu(f.anchorOrigin),
                        y = L[d] || [];
                    return F({}, L, (c = {}, c[d] = [].concat(y, [f]), c))
                }, {}),
                x = Object.keys(g).map(function(L) {
                    var f = g[L],
                        c = f[0];
                    return A.createElement(vp, {
                        key: L,
                        dense: m,
                        anchorOrigin: c.anchorOrigin,
                        classes: C
                    }, f.map(function(d) {
                        return A.createElement(mp, {
                            key: d.id,
                            snack: d,
                            classes: C,
                            Component: h[d.variant],
                            onClose: l.handleCloseSnack,
                            onEnter: l.props.onEnter,
                            onExit: l.props.onExit,
                            onExited: Gt([l.handleExitedSnack, l.props.onExited], d.id),
                            onEntered: Gt([l.handleEnteredSnack, l.props.onEntered], d.id)
                        })
                    }))
                });
            return A.createElement(cf.Provider, {
                value: i
            }, a, u ? lf.createPortal(x, u) : x)
        }, af(n, [{
            key: "maxSnack",
            get: function() {
                return this.props.maxSnack || Rn.maxSnack
            }
        }]), n
    }(T.Component),
    yp = function() {
        return T.useContext(cf)
    };
const Co = T.forwardRef(({
                             ...e
                         }, n) => {
    let t = e.distance,
        r = "red",
        l = "m";
    if (t < 3e3 && (r = "yellow"), t < 1e3 && (r = "green"), t > 1e3) {
        const s = Number(t / 1e3).toFixed(1);
        t = Number(s), l = "km"
    }
    let i = e.distancepnj,
        o = "red",
        u = "m";
    if (i < 3e3 && (o = "yellow"), i < 1e3 && (o = "green"), i > 1e3) {
        const s = Number(i / 1e3).toFixed(1);
        i = Number(s), u = "km"
    }
    return p.jsx(xu, {
        ref: n,
        children: e.type === "VISION" ? p.jsxs("div", {
            className: "_notification showAnnonce",
            children: [p.jsx("div", {
                className: "img",
                children: p.jsx("img", {
                    src: "./vision.png"
                })
            }), p.jsxs("div", {
                className: "infos",
                children: [p.jsx("div", {
                    className: "name A-FadeInLeft",
                    style: {
                        animationDelay: "1.3s"
                    },
                    children: "VISION"
                }), p.jsx("div", {
                    className: e.typeannonce.toLowerCase() + " A-FadeInLeft",
                    style: {
                        animationDelay: "1.6s"
                    },
                    children: e.labeltype
                }), p.jsx("div", {
                    className: "message A-FadeInLeft",
                    style: {
                        animationDelay: "1.9s"
                    },
                    children: e.parsedContent
                })]
            }), e.duration && p.jsx("div", {
                className: "timer A-FadeIn",
                style: {
                    animationDelay: "2s"
                },
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        }) : e.type === "MISSIONTAXI" ? p.jsxs("div", {
            className: "notification police",
            children: [p.jsxs("div", {
                className: "top",
                children: [p.jsx("div", {
                    style: {
                        marginLeft: 12.5
                    },
                    children: e.title
                }), p.jsxs("svg", {
                    style: {
                        marginRight: 9
                    },
                    width: "48",
                    height: "23",
                    viewBox: "0 0 48 23",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: [p.jsx("path", {
                        d: "M11.0969 21.0002C16.2331 21.0002 20.3969 16.7021 20.3969 11.4002C20.3969 6.09824 16.2331 1.80017 11.0969 1.80017C5.96063 1.80017 1.79688 6.09824 1.79688 11.4002C1.79688 16.7021 5.96063 21.0002 11.0969 21.0002Z",
                        fill: "black",
                        fillOpacity: "0.55"
                    }), p.jsx("path", {
                        d: "M22.2 11.4C22.2 17.696 17.2304 22.8 11.1 22.8C4.96964 22.8 0 17.696 0 11.4C0 5.10395 4.96964 0 11.1 0C17.2304 0 22.2 5.10395 22.2 11.4ZM2.11657 11.4C2.11657 16.4955 6.13859 20.6262 11.1 20.6262C16.0614 20.6262 20.0834 16.4955 20.0834 11.4C20.0834 6.3045 16.0614 2.17378 11.1 2.17378C6.13859 2.17378 2.11657 6.3045 2.11657 11.4Z",
                        fill: "url(#paint0_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M12.195 12.23V15H10.505V12.23L7.86499 7.71503H9.35499C9.50166 7.71503 9.61666 7.75003 9.69999 7.82003C9.78666 7.8867 9.85832 7.97336 9.91499 8.08003L10.945 10.2C11.0317 10.3667 11.11 10.5233 11.18 10.67C11.25 10.8133 11.3117 10.955 11.365 11.095C11.415 10.9517 11.4717 10.8083 11.535 10.665C11.6017 10.5183 11.6783 10.3633 11.765 10.2L12.785 8.08003C12.8083 8.0367 12.8367 7.99336 12.87 7.95003C12.9033 7.9067 12.9417 7.86836 12.985 7.83503C13.0317 7.79836 13.0833 7.77003 13.14 7.75003C13.2 7.7267 13.265 7.71503 13.335 7.71503H14.835L12.195 12.23Z",
                        fill: "url(#paint1_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M36.0969 21C41.2331 21 45.3969 16.7019 45.3969 11.4C45.3969 6.09805 41.2331 1.79999 36.0969 1.79999C30.9606 1.79999 26.7969 6.09805 26.7969 11.4C26.7969 16.7019 30.9606 21 36.0969 21Z",
                        fill: "black",
                        fillOpacity: "0.55"
                    }), p.jsx("path", {
                        d: "M47.2 11.4C47.2 17.696 42.2304 22.8 36.1 22.8C29.9696 22.8 25 17.696 25 11.4C25 5.10395 29.9696 0 36.1 0C42.2304 0 47.2 5.10395 47.2 11.4ZM27.1166 11.4C27.1166 16.4955 31.1386 20.6262 36.1 20.6262C41.0614 20.6262 45.0834 16.4955 45.0834 11.4C45.0834 6.3045 41.0614 2.17378 36.1 2.17378C31.1386 2.17378 27.1166 6.3045 27.1166 11.4Z",
                        fill: "url(#paint2_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M39.0651 7.71503V15H38.1851C38.0551 15 37.9451 14.98 37.8551 14.94C37.7684 14.8967 37.6818 14.8233 37.5951 14.72L34.1601 10.375C34.1734 10.505 34.1818 10.6317 34.1851 10.755C34.1918 10.875 34.1951 10.9883 34.1951 11.095V15H32.7051V7.71503H33.5951C33.6684 7.71503 33.7301 7.71836 33.7801 7.72503C33.8301 7.7317 33.8751 7.74503 33.9151 7.76503C33.9551 7.7817 33.9934 7.8067 34.0301 7.84003C34.0668 7.87336 34.1084 7.91836 34.1551 7.97503L37.6201 12.35C37.6034 12.21 37.5918 12.075 37.5851 11.945C37.5784 11.8117 37.5751 11.6867 37.5751 11.57V7.71503H39.0651Z",
                        fill: "url(#paint3_linear_0_1)"
                    }), p.jsxs("defs", {
                        children: [p.jsxs("linearGradient", {
                            id: "paint0_linear_0_1",
                            x1: "11.1",
                            y1: "0",
                            x2: "11.1",
                            y2: "22.8",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "#38DC66"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#33963C"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint1_linear_0_1",
                            x1: "524.237",
                            y1: "2.00003",
                            x2: "524.237",
                            y2: "21.2",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "white"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#BFBFBF"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint2_linear_0_1",
                            x1: "36.1",
                            y1: "0",
                            x2: "36.1",
                            y2: "22.8",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "#E01F1F"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#C21D30"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint3_linear_0_1",
                            x1: "548.237",
                            y1: "2.00003",
                            x2: "548.237",
                            y2: "21.2",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "white"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#CDCDCD"
                            })]
                        })]
                    })]
                })]
            }), p.jsxs("div", {
                className: "main",
                children: [p.jsxs("div", {
                    className: "line",
                    children: [p.jsx("img", {
                        src: "./person.svg",
                        className: "A-BounceIn",
                        style: {
                            animationDelay: ".8s"
                        }
                    }), p.jsx("div", {
                        className: "value A-FadeInLeft",
                        style: {
                            textTransform: "uppercase",
                            animationDelay: "1s"
                        },
                        children: e.adress
                    })]
                }), p.jsxs("div", {
                    className: "line",
                    children: [p.jsx("img", {
                        src: "./map.svg",
                        className: "A-BounceIn",
                        style: {
                            animationDelay: ".8s"
                        }
                    }), p.jsx("div", {
                        className: "value A-FadeInLeft ",
                        style: {
                            textTransform: "uppercase",
                            animationDelay: "1s"
                        },
                        children: e.adress2
                    })]
                })]
            }), p.jsxs("div", {
                className: "distancepnj " + o + " A-BounceIn",
                style: {
                    animationDelay: "1.3s"
                },
                children: [i, u]
            }), p.jsxs("div", {
                className: "distance " + r + " A-BounceIn",
                style: {
                    animationDelay: "1.3s"
                },
                children: [t, l]
            }), e.duration && p.jsx("div", {
                className: "timer",
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        }) : e.type === "ALERTEJOBS" ? p.jsxs("div", {
            className: "notification police",
            children: [p.jsxs("div", {
                className: "top",
                children: [p.jsxs("div", {
                    style: {
                        display: "flex",
                        alignItems: "center"
                    },
                    children: [p.jsx("div", {
                        style: {
                            fontSize: 17,
                            marginLeft: 12.5,
                            marginRight: 8
                        },
                        children: e.title
                    }), p.jsxs("svg", {
                        width: "10",
                        height: "10",
                        viewBox: "0 0 30 30",
                        fill: "none",
                        xmlns: "http://www.w3.org/2000/svg",
                        children: [p.jsx("g", {
                            filter: "url(#filter0_d_1987_59)",
                            children: p.jsx("circle", {
                                cx: "14.9388",
                                cy: "14.5968",
                                r: "12.2903",
                                fill: "url(#paint0_linear_1987_59)"
                            })
                        }), p.jsxs("defs", {
                            children: [p.jsxs("filter", {
                                id: "filter0_d_1987_59",
                                x: "0.648438",
                                y: "0.806519",
                                width: "28.5781",
                                height: "28.5807",
                                filterUnits: "userSpaceOnUse",
                                colorInterpolationFilters: "sRGB",
                                children: [p.jsx("feFlood", {
                                    floodOpacity: "0",
                                    result: "BackgroundImageFix"
                                }), p.jsx("feColorMatrix", {
                                    in: "SourceAlpha",
                                    type: "matrix",
                                    values: "0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 127 0",
                                    result: "hardAlpha"
                                }), p.jsx("feOffset", {
                                    dy: "0.5"
                                }), p.jsx("feGaussianBlur", {
                                    stdDeviation: "1"
                                }), p.jsx("feComposite", {
                                    in2: "hardAlpha",
                                    operator: "out"
                                }), p.jsx("feColorMatrix", {
                                    type: "matrix",
                                    values: "0 0 0 0 0.219608 0 0 0 0 0.843137 0 0 0 0 0.388235 0 0 0 1 0"
                                }), p.jsx("feBlend", {
                                    mode: "normal",
                                    in2: "BackgroundImageFix",
                                    result: "effect1_dropShadow_1987_59"
                                }), p.jsx("feBlend", {
                                    mode: "normal",
                                    in: "SourceGraphic",
                                    in2: "effect1_dropShadow_1987_59",
                                    result: "shape"
                                })]
                            }), p.jsxs("linearGradient", {
                                id: "paint0_linear_1987_59",
                                x1: "14.9388",
                                y1: "2.30652",
                                x2: "14.9388",
                                y2: "26.8872",
                                gradientUnits: "userSpaceOnUse",
                                children: [p.jsx("stop", {
                                    stopColor: "#38D964"
                                }), p.jsx("stop", {
                                    offset: "1",
                                    stopColor: "#33983D"
                                })]
                            })]
                        })]
                    })]
                }), p.jsxs("svg", {
                    style: {
                        marginRight: 9
                    },
                    width: "48",
                    height: "23",
                    viewBox: "0 0 48 23",
                    fill: "none",
                    xmlns: "http://www.w3.org/2000/svg",
                    children: [p.jsx("path", {
                        d: "M11.0969 21.0002C16.2331 21.0002 20.3969 16.7021 20.3969 11.4002C20.3969 6.09824 16.2331 1.80017 11.0969 1.80017C5.96063 1.80017 1.79688 6.09824 1.79688 11.4002C1.79688 16.7021 5.96063 21.0002 11.0969 21.0002Z",
                        fill: "black",
                        fillOpacity: "0.55"
                    }), p.jsx("path", {
                        d: "M22.2 11.4C22.2 17.696 17.2304 22.8 11.1 22.8C4.96964 22.8 0 17.696 0 11.4C0 5.10395 4.96964 0 11.1 0C17.2304 0 22.2 5.10395 22.2 11.4ZM2.11657 11.4C2.11657 16.4955 6.13859 20.6262 11.1 20.6262C16.0614 20.6262 20.0834 16.4955 20.0834 11.4C20.0834 6.3045 16.0614 2.17378 11.1 2.17378C6.13859 2.17378 2.11657 6.3045 2.11657 11.4Z",
                        fill: "url(#paint0_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M12.195 12.23V15H10.505V12.23L7.86499 7.71503H9.35499C9.50166 7.71503 9.61666 7.75003 9.69999 7.82003C9.78666 7.8867 9.85832 7.97336 9.91499 8.08003L10.945 10.2C11.0317 10.3667 11.11 10.5233 11.18 10.67C11.25 10.8133 11.3117 10.955 11.365 11.095C11.415 10.9517 11.4717 10.8083 11.535 10.665C11.6017 10.5183 11.6783 10.3633 11.765 10.2L12.785 8.08003C12.8083 8.0367 12.8367 7.99336 12.87 7.95003C12.9033 7.9067 12.9417 7.86836 12.985 7.83503C13.0317 7.79836 13.0833 7.77003 13.14 7.75003C13.2 7.7267 13.265 7.71503 13.335 7.71503H14.835L12.195 12.23Z",
                        fill: "url(#paint1_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M36.0969 21C41.2331 21 45.3969 16.7019 45.3969 11.4C45.3969 6.09805 41.2331 1.79999 36.0969 1.79999C30.9606 1.79999 26.7969 6.09805 26.7969 11.4C26.7969 16.7019 30.9606 21 36.0969 21Z",
                        fill: "black",
                        fillOpacity: "0.55"
                    }), p.jsx("path", {
                        d: "M47.2 11.4C47.2 17.696 42.2304 22.8 36.1 22.8C29.9696 22.8 25 17.696 25 11.4C25 5.10395 29.9696 0 36.1 0C42.2304 0 47.2 5.10395 47.2 11.4ZM27.1166 11.4C27.1166 16.4955 31.1386 20.6262 36.1 20.6262C41.0614 20.6262 45.0834 16.4955 45.0834 11.4C45.0834 6.3045 41.0614 2.17378 36.1 2.17378C31.1386 2.17378 27.1166 6.3045 27.1166 11.4Z",
                        fill: "url(#paint2_linear_0_1)"
                    }), p.jsx("path", {
                        d: "M39.0651 7.71503V15H38.1851C38.0551 15 37.9451 14.98 37.8551 14.94C37.7684 14.8967 37.6818 14.8233 37.5951 14.72L34.1601 10.375C34.1734 10.505 34.1818 10.6317 34.1851 10.755C34.1918 10.875 34.1951 10.9883 34.1951 11.095V15H32.7051V7.71503H33.5951C33.6684 7.71503 33.7301 7.71836 33.7801 7.72503C33.8301 7.7317 33.8751 7.74503 33.9151 7.76503C33.9551 7.7817 33.9934 7.8067 34.0301 7.84003C34.0668 7.87336 34.1084 7.91836 34.1551 7.97503L37.6201 12.35C37.6034 12.21 37.5918 12.075 37.5851 11.945C37.5784 11.8117 37.5751 11.6867 37.5751 11.57V7.71503H39.0651Z",
                        fill: "url(#paint3_linear_0_1)"
                    }), p.jsxs("defs", {
                        children: [p.jsxs("linearGradient", {
                            id: "paint0_linear_0_1",
                            x1: "11.1",
                            y1: "0",
                            x2: "11.1",
                            y2: "22.8",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "#38DC66"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#33963C"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint1_linear_0_1",
                            x1: "524.237",
                            y1: "2.00003",
                            x2: "524.237",
                            y2: "21.2",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "white"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#BFBFBF"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint2_linear_0_1",
                            x1: "36.1",
                            y1: "0",
                            x2: "36.1",
                            y2: "22.8",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "#E01F1F"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#C21D30"
                            })]
                        }), p.jsxs("linearGradient", {
                            id: "paint3_linear_0_1",
                            x1: "548.237",
                            y1: "2.00003",
                            x2: "548.237",
                            y2: "21.2",
                            gradientUnits: "userSpaceOnUse",
                            children: [p.jsx("stop", {
                                stopColor: "white"
                            }), p.jsx("stop", {
                                offset: "1",
                                stopColor: "#CDCDCD"
                            })]
                        })]
                    })]
                })]
            }), p.jsxs("div", {
                className: "main",
                children: [p.jsxs("div", {
                    className: "line",
                    children: [p.jsx("img", {
                        src: "./info.svg",
                        className: " A-BounceIn",
                        style: {
                            animationDelay: ".8s"
                        }
                    }), p.jsx("div", {
                        className: "value A-FadeInLeft",
                        style: {
                            animationDelay: "1s"
                        },
                        children: e.name.charAt(0).toUpperCase() + e.name.slice(1)
                    })]
                }), p.jsxs("div", {
                    className: "line",
                    children: [p.jsx("img", {
                        src: "./map.svg",
                        className: " A-BounceIn",
                        style: {
                            animationDelay: ".8s"
                        }
                    }), p.jsx("div", {
                        className: "value A-FadeInLeft ",
                        style: {
                            animationDelay: "1s"
                        },
                        children: e.adress
                    })]
                }), p.jsxs("div", {
                    className: "line",
                    children: [p.jsx("img", {
                        src: "./police.svg",
                        className: " A-BounceIn",
                        style: {
                            animationDelay: ".8s"
                        }
                    }), p.jsx("div", {
                        className: "value A-FadeInLeft ",
                        style: {
                            animationDelay: "1s"
                        },
                        children: e.utils
                    })]
                })]
            }), p.jsxs("div", {
                className: "distance " + r + " A-BounceIn",
                style: {
                    animationDelay: "1.3s"
                },
                children: [t, l]
            }), e.duration && p.jsx("div", {
                className: "timer",
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        }) : e.type === "JOB" ? p.jsxs("div", {
            className: "_notification showAnnonce" + (e != null && e.staffReason ? " staff" : ""),
            children: [p.jsx("div", {
                className: "img",
                children: p.jsx("img", {
                    src: e.logo
                })
            }), p.jsxs("div", {
                className: "infos",
                children: [p.jsx("div", {
                    className: "name A-FadeInLeft",
                    style: {
                        animationDelay: "1.3s"
                    },
                    children: e.name
                }), p.jsx("div", {
                    className: e.typeannonce.toLowerCase() + " A-FadeInLeft",
                    style: {
                        animationDelay: "1.6s"
                    },
                    children: e.typeannonce.toUpperCase()
                }), e.staffReason == 1 && p.jsx("div", {
                    style: {
                        fontSize: 10,
                        fontWeight: 300,
                        textTransform: "uppercase",
                        fontFamily: "Lato",
                        padding: "2px 8px",
                        borderRadius: 5,
                        marginBottom: 0,
                        width: "fit-content",
                        color: "#fff",
                        background: "linear-gradient(180deg, rgba(253, 127, 127, 0.5) 0%, rgba(224, 31, 31, 0.5) 100%)"
                    },
                    children: (e == null ? void 0 : e.overrideCategory) ?? "Report RP"
                }), e.staffReason == 2 && p.jsx("div", {
                    style: {
                        fontSize: 10,
                        fontWeight: 300,
                        textTransform: "uppercase",
                        fontFamily: "Lato",
                        padding: "2px 8px",
                        borderRadius: 5,
                        width: "fit-content",
                        marginBottom: 0,
                        color: "#fff",
                        background: "linear-gradient(180deg, rgba(251, 188, 4, 0.55) 0%, rgba(251, 157, 4, 0.55) 100%)"
                    },
                    children: (e == null ? void 0 : e.overrideCategory) ?? "REPORT BUG"
                }), e.staffReason == 3 && p.jsx("div", {
                    style: {
                        fontSize: 10,
                        fontWeight: 300,
                        textTransform: "uppercase",
                        fontFamily: "Lato",
                        padding: "2px 8px",
                        borderRadius: 5,
                        width: "fit-content",
                        color: "#fff",
                        marginBottom: 0,
                        background: "linear-gradient(180deg, rgba(94, 108, 182, 0.8) 0%, rgba(94, 108, 182, 0.496) 100%)"
                    },
                    children: (e == null ? void 0 : e.overrideCategory) ?? "BOUTIQUE"
                }), e.staffReason && p.jsx("div", {
                    className: "ReportAccept",
                    children: p.jsxs("svg", {
                        style: {
                            marginRight: 9
                        },
                        width: "48",
                        height: "23",
                        viewBox: "0 0 48 23",
                        fill: "none",
                        xmlns: "http://www.w3.org/2000/svg",
                        children: [p.jsx("path", {
                            d: "M11.0969 21.0002C16.2331 21.0002 20.3969 16.7021 20.3969 11.4002C20.3969 6.09824 16.2331 1.80017 11.0969 1.80017C5.96063 1.80017 1.79688 6.09824 1.79688 11.4002C1.79688 16.7021 5.96063 21.0002 11.0969 21.0002Z",
                            fill: "black",
                            fillOpacity: "0.55"
                        }), p.jsx("path", {
                            d: "M22.2 11.4C22.2 17.696 17.2304 22.8 11.1 22.8C4.96964 22.8 0 17.696 0 11.4C0 5.10395 4.96964 0 11.1 0C17.2304 0 22.2 5.10395 22.2 11.4ZM2.11657 11.4C2.11657 16.4955 6.13859 20.6262 11.1 20.6262C16.0614 20.6262 20.0834 16.4955 20.0834 11.4C20.0834 6.3045 16.0614 2.17378 11.1 2.17378C6.13859 2.17378 2.11657 6.3045 2.11657 11.4Z",
                            fill: "url(#paint0_linear_0_1)"
                        }), p.jsx("path", {
                            d: "M12.195 12.23V15H10.505V12.23L7.86499 7.71503H9.35499C9.50166 7.71503 9.61666 7.75003 9.69999 7.82003C9.78666 7.8867 9.85832 7.97336 9.91499 8.08003L10.945 10.2C11.0317 10.3667 11.11 10.5233 11.18 10.67C11.25 10.8133 11.3117 10.955 11.365 11.095C11.415 10.9517 11.4717 10.8083 11.535 10.665C11.6017 10.5183 11.6783 10.3633 11.765 10.2L12.785 8.08003C12.8083 8.0367 12.8367 7.99336 12.87 7.95003C12.9033 7.9067 12.9417 7.86836 12.985 7.83503C13.0317 7.79836 13.0833 7.77003 13.14 7.75003C13.2 7.7267 13.265 7.71503 13.335 7.71503H14.835L12.195 12.23Z",
                            fill: "url(#paint1_linear_0_1)"
                        }), p.jsx("path", {
                            d: "M36.0969 21C41.2331 21 45.3969 16.7019 45.3969 11.4C45.3969 6.09805 41.2331 1.79999 36.0969 1.79999C30.9606 1.79999 26.7969 6.09805 26.7969 11.4C26.7969 16.7019 30.9606 21 36.0969 21Z",
                            fill: "black",
                            fillOpacity: "0.55"
                        }), p.jsx("path", {
                            d: "M47.2 11.4C47.2 17.696 42.2304 22.8 36.1 22.8C29.9696 22.8 25 17.696 25 11.4C25 5.10395 29.9696 0 36.1 0C42.2304 0 47.2 5.10395 47.2 11.4ZM27.1166 11.4C27.1166 16.4955 31.1386 20.6262 36.1 20.6262C41.0614 20.6262 45.0834 16.4955 45.0834 11.4C45.0834 6.3045 41.0614 2.17378 36.1 2.17378C31.1386 2.17378 27.1166 6.3045 27.1166 11.4Z",
                            fill: "url(#paint2_linear_0_1)"
                        }), p.jsx("path", {
                            d: "M39.0651 7.71503V15H38.1851C38.0551 15 37.9451 14.98 37.8551 14.94C37.7684 14.8967 37.6818 14.8233 37.5951 14.72L34.1601 10.375C34.1734 10.505 34.1818 10.6317 34.1851 10.755C34.1918 10.875 34.1951 10.9883 34.1951 11.095V15H32.7051V7.71503H33.5951C33.6684 7.71503 33.7301 7.71836 33.7801 7.72503C33.8301 7.7317 33.8751 7.74503 33.9151 7.76503C33.9551 7.7817 33.9934 7.8067 34.0301 7.84003C34.0668 7.87336 34.1084 7.91836 34.1551 7.97503L37.6201 12.35C37.6034 12.21 37.5918 12.075 37.5851 11.945C37.5784 11.8117 37.5751 11.6867 37.5751 11.57V7.71503H39.0651Z",
                            fill: "url(#paint3_linear_0_1)"
                        }), p.jsxs("defs", {
                            children: [p.jsxs("linearGradient", {
                                id: "paint0_linear_0_1",
                                x1: "11.1",
                                y1: "0",
                                x2: "11.1",
                                y2: "22.8",
                                gradientUnits: "userSpaceOnUse",
                                children: [p.jsx("stop", {
                                    stopColor: "#38DC66"
                                }), p.jsx("stop", {
                                    offset: "1",
                                    stopColor: "#33963C"
                                })]
                            }), p.jsxs("linearGradient", {
                                id: "paint1_linear_0_1",
                                x1: "524.237",
                                y1: "2.00003",
                                x2: "524.237",
                                y2: "21.2",
                                gradientUnits: "userSpaceOnUse",
                                children: [p.jsx("stop", {
                                    stopColor: "white"
                                }), p.jsx("stop", {
                                    offset: "1",
                                    stopColor: "#BFBFBF"
                                })]
                            }), p.jsxs("linearGradient", {
                                id: "paint2_linear_0_1",
                                x1: "36.1",
                                y1: "0",
                                x2: "36.1",
                                y2: "22.8",
                                gradientUnits: "userSpaceOnUse",
                                children: [p.jsx("stop", {
                                    stopColor: "#E01F1F"
                                }), p.jsx("stop", {
                                    offset: "1",
                                    stopColor: "#C21D30"
                                })]
                            }), p.jsxs("linearGradient", {
                                id: "paint3_linear_0_1",
                                x1: "548.237",
                                y1: "2.00003",
                                x2: "548.237",
                                y2: "21.2",
                                gradientUnits: "userSpaceOnUse",
                                children: [p.jsx("stop", {
                                    stopColor: "white"
                                }), p.jsx("stop", {
                                    offset: "1",
                                    stopColor: "#CDCDCD"
                                })]
                            })]
                        })]
                    })
                }), p.jsx("div", {
                    className: "message A-FadeInLeft",
                    style: {
                        animationDelay: "1.9s"
                    },
                    children: e.parsedContent
                }), p.jsx("div", {
                    className: "phone A-FadeInUp",
                    style: {
                        marginRight: e.staff ? -13 : 0,
                        animationDelay: "1.6s"
                    },
                    children: e.phone
                }), !e.staff && p.jsx("img", {
                    className: "phonelogo A-FadeInUp",
                    src: "./green-phone.png",
                    style: {
                        animationDelay: "1.6s"
                    }
                })]
            }), e.duration && p.jsx("div", {
                className: "timer A-FadeIn",
                style: {
                    animationDelay: "2s"
                },
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        }) : e.type === "ILLEGAL" ? p.jsxs("div", {
            className: "_notification showAnnonce illegal",
            children: [p.jsx("div", {
                className: "img",
                children: p.jsx("img", {
                    src: e.logo
                })
            }), p.jsxs("div", {
                className: "infos",
                children: [p.jsx("div", {
                    className: "name A-FadeInLeft",
                    style: {
                        animationDelay: "1.3s"
                    },
                    children: e.name
                }), p.jsx("div", {
                    style: {
                        fontSize: 10,
                        fontWeight: 300,
                        textTransform: "uppercase",
                        fontFamily: "Lato",
                        padding: "2px 8px",
                        borderRadius: 3,
                        width: "fit-content",
                        color: "#fff",
                        background: `linear-gradient(180deg, ${e.labelColor}95 0%, ${e.labelColor}FF 100%)`
                    },
                    children: e.label
                }), p.jsx("div", {
                    className: "message A-FadeInLeft",
                    style: {
                        animationDelay: "1.9s"
                    },
                    children: e.mainMessage
                })]
            }), e.duration && p.jsx("div", {
                className: "timer A-FadeIn",
                style: {
                    animationDelay: "2s"
                },
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        }) : p.jsxs("div", {
            style: {
                "--color": e.color,
                padding: "3px"
            },
            className: `notification ${e!=null&&e.hasSpecialColor?"--special-color":""}`,
            id: e.id,
            children: [p.jsx("div", {
                className: "left A-BounceIn",
                style: {
                    animationDelay: "0.8s"
                },
                children: p.jsx("div", {
                    className: "icon__wrapper",
                    dangerouslySetInnerHTML: {
                        __html: e.icon
                    }
                })
            }), p.jsx("div", {
                className: "right A-FadeInLeft",
                dangerouslySetInnerHTML: {
                    __html: e.parsedContent
                },
                style: {
                    fontSize: 12,
                    animationDelay: "1s"
                }
            }), e.duration && p.jsx("div", {
                className: "timer",
                children: p.jsx("div", {
                    className: "track",
                    style: {
                        animationDuration: e.duration + "s"
                    }
                })
            })]
        })
    })
});
Co.displayName = "ReportComplete";
const xp = [{
        type: "ROUGE",
        color: "linear-gradient(180deg, #FF0000 0%, #FF0000 100%)"
    }, {
        type: "VERT",
        color: "linear-gradient(180deg, #38DC66 0%, #33963C 100%)"
    }, {
        type: "JAUNE",
        color: "linear-gradient(180deg, #FBD604 0%, #FBCB04 100%)"
    }, {
        type: "BLEU",
        color: "linear-gradient(180deg, #2FF5E4 0%, #44C7F0 100%)"
    }, {
        type: "VIOLET",
        color: "linear-gradient(180deg, #9D49EA 0%, #872ADB 100%)"
    }, {
        type: "BLANC",
        color: "linear-gradient(180deg, #fff 0%, #fff 100%)"
    }, {
        type: "CLOCHE",
        color: "linear-gradient(180deg, #2FF5E4 0%, #44C7F0 100%)"
    }, {
        type: "DOLLAR",
        color: "linear-gradient(180deg, #FBD604 0%, #FBCB04 100%)"
    }, {
        type: "SYNC",
        color: "linear-gradient(180deg, #38DC66 0%, #33963C 100%)"
    }, {
        type: "BURGER",
        color: "linear-gradient(180deg, #38DC66 0%, #33963C 100%)"
    }, {
        type: "RMIC",
        color: "linear-gradient(180deg, #FF0000 0%, #FF0000 100%)"
    }, {
        type: "VMIC",
        color: "linear-gradient(180deg, #38DC66 0%, #33963C 100%)"
    }],
    wp = e => {
        var n;
        return (n = xp.find(t => t.type === e)) == null ? void 0 : n.color
    },
    Cp = e => {
        if (!e) return e;
        const n = /~K\s*(\w+)/g,
            t = e.match(n);
        if (!t) return e;
        for (const r of t) e = e.replace(n, `<span class="special-key">${r}</span>`), e = e.replace("~K", "");
        return e
    },
    kp = (e, n) => {
        const t = /~[sc]/g,
            r = e == null ? void 0 : e.match(t),
            l = wp(n);
        if (!l) return {
            content: e,
            hasSpecialColor: !1,
            color: void 0
        };
        if (e = Cp(e), console.log(e), !r) return {
            content: e,
            hasSpecialColor: !1,
            color: l
        };
        for (const i of r) e = i === "~c" ? e.replace(`${i}`, "</span>") : e.replace(`${i}`, `<span class="special-color" style="--color: ${l}">`);
        return console.log(e), {
            content: e,
            hasSpecialColor: !0,
            color: l
        }
    };
const Wa = ({
                label: e,
                height: n,
                width: t,
                fontSize: r,
                fontWeight: l,
                color: i,
                margin: o,
                callback: u,
                selected: a,
                padding: s,
                children: m,
                selectedStyle: v = {
                    filter: "brightness(1.1)"
                },
                disabled: h = !1,
                readOnly: C = !1
            }) => p.jsxs("div", {
        onClick: () => {
            u && u()
        },
        className: "buttonCustom " + i + " " + (h ? "disabled" : "") + (C ? "readOnly" : ""),
        style: {
            height: n,
            width: t,
            fontSize: r,
            fontWeight: l,
            padding: s,
            margin: o,
            ...a ? {
                ...v
            } : {}
        },
        children: [e, m]
    }),
    Sp = () => (yp(), p.jsx(p.Fragment, {}));

function Ep() {
    const e = T.useRef(null),
        [n, t] = T.useState({}),
        [r, l] = T.useState(!0),
        [i, o] = T.useState([]),
        [u, a] = T.useState(!1),
        [s, m] = T.useState(null),
        v = T.useRef(i);
    v.current = i;
    const h = x => {
        const {
            action: L,
            data: f
        } = x.data;
        if (L === "__vision::disableNotifications" && a(f), !u) {
            if (L === "__vision::createNotification") {
                const {
                    content: c,
                    ...d
                } = f;
                if (f.type === "WEAZEL") {
                    o([...i, f]);
                    return
                }
                const {
                    content: y,
                    hasSpecialColor: S,
                    color: E
                } = kp(c, f.type);
                t({
                    ...d,
                    parsedContent: y,
                    hasSpecialColor: S,
                    color: E,
                    autoHideDuration: (d == null ? void 0 : d.duration) * 1e3
                });
                const w = document.querySelector(".notistack-SnackbarContainer");
                let _ = 0;
                w && w.childElementCount === 6 && (_ = 500);
                const R = ((d == null ? void 0 : d.duration) ?? 5) * 1e3;
                let P = Number((w == null ? void 0 : w.style.marginBottom.replace(/\D/g, "")) ?? 0);
                setTimeout(() => {
                    var nn;
                    const q = ((nn = e.current) == null ? void 0 : nn.clientHeight) + 6;
                    w && ((w == null ? void 0 : w.clientHeight) ?? 0) > 0 ? (w.style.transition = "0.2s", w.style.marginBottom = `${P+q}px`, setTimeout(() => {
                        wo("", {
                            variant: "reportComplete",
                            ...d,
                            parsedContent: y,
                            hasSpecialColor: S,
                            color: E,
                            autoHideDuration: R
                        }), setTimeout(() => {
                            const Pe = document.querySelector(".notistack-SnackbarContainer");
                            P = Number((Pe == null ? void 0 : Pe.style.marginBottom.replace(/\D/g, "")) ?? 0), Pe.style.transition = "none", Pe.style.marginBottom = `${P-q}`
                        }, _)
                    }, 200)) : wo("", {
                        variant: "reportComplete",
                        ...d,
                        parsedContent: y,
                        hasSpecialColor: S,
                        color: E,
                        autoHideDuration: R
                    })
                }, 100)
            }
            L === "__vision::updateNotificationHudState" && l(f)
        }
    };
    T.useEffect(() => (window.addEventListener("message", h), () => window.removeEventListener("message", h)));
    const C = () => {
        const x = [...v.current];
        x.shift(), m(null), o(L => x)
    };
    T.useEffect(() => {
        i.length > 0 && !s && (setTimeout(C, 1e4, i), m(i[0]))
    }, [i]);
    const g = () => {
        switch (s == null ? void 0 : s.category) {
            case "fame":
                return "black";
            case "media":
                return "blue";
            case "news":
                return "darkred";
            case "music":
                return "yellow"
        }
    };
    return p.jsxs("div", {
        className: r ? "hud" : "",
        children: [s && p.jsxs("div", {
            className: "WeazelNewsShow",
            children: [p.jsx("img", {
                src: `./${s.category}.png`
            }), p.jsxs("div", {
                style: {
                    margin: "30px 0 15px 20px",
                    display: "flex",
                    gap: 20,
                    alignItems: "center"
                },
                children: [p.jsx(Wa, {
                    label: "WEAZEL " + s.category.toUpperCase(),
                    readOnly: !0,
                    color: g(),
                    disabled: !1,
                    width: 180,
                    height: 25,
                    fontSize: 16,
                    fontWeight: 700
                }), p.jsx("div", {
                    className: "title",
                    children: s.title
                })]
            }), p.jsx("img", {
                className: "mainImg",
                src: s.image
            }), p.jsx(Wa, {
                label: s.message,
                readOnly: !0,
                color: g(),
                disabled: !1,
                margin: "10px auto 0",
                width: "fit-content",
                height: 25,
                fontSize: 20,
                padding: "10px",
                fontWeight: 700
            }), p.jsx("div", {
                className: "span",
                children: s.author
            })]
        }), p.jsx(gp, {
            maxSnack: 6,
            Components: {
                reportComplete: Co
            },
            children: p.jsxs("div", {
                style: {
                    height: "100vh",
                    width: "100vw",
                    display: "flex",
                    alignItems: "center",
                    justifyContent: "center"
                },
                children: [p.jsx(Sp, {}), p.jsx("div", {
                    className: "holder",
                    ref: e,
                    children: p.jsx(Co, {
                        ...n
                    })
                })]
            })
        })]
    })
}
Ei.createRoot(document.getElementById("root")).render(p.jsx(Ep, {}));