def launch_attack(P, Q, p, a, b, debug = False):
    if p>2^50:
        debug = False
    E = P.curve()
    Eqp = EllipticCurve(Qp(p, 8), [a,b])
    if debug:
        print(f"Lifted curve: {Eqp}")
    P_Qps = Eqp.lift_x(ZZ(P.xy()[0]), all=True)
    for P_Qp in P_Qps:
        if GF(p)(P_Qp.xy()[1]) == P.xy()[1]:
            break
    Q_Qps = Eqp.lift_x(ZZ(Q.xy()[0]), all=True)
    for Q_Qp in Q_Qps:
        if GF(p)(Q_Qp.xy()[1]) == Q.xy()[1]:
            break
    if debug:
        print(f"P lifted to ({P_Qp.xy()[0]}, {P_Qp.xy()[1]})")
        print(f"Q lifted to ({Q_Qp.xy()[0]}, {Q_Qp.xy()[1]})")
    p_times_P = p * P_Qp
    p_times_Q = p * Q_Qp
    x_P, y_P = p_times_P.xy()
    x_Q, y_Q = p_times_Q.xy()
    if debug:
        print(f"pP = ({x_P}, {y_P})")
        print(f"pQ = ({x_Q}, {y_Q})")
    phi_P = -(x_P / y_P)
    phi_Q = -(x_Q / y_Q)
    if debug:
        print(f"log(pP) = {phi_P}")
        print(f"log(pQ) = {phi_Q}")
    k = phi_Q / phi_P
    return ZZ(k) % p

p, a, b = 43, 36, 14
s = 9

m = 13371337
p = 185011641246174257751891815434570985671
a = 13770871008086690904740185066746819703
b = 135573008985790615472417463564391763513
n = 106165271208798914670517880957853289447
k = 135581648184571575296963620639402230489
a = a+m*p
b = b+(n+m*k)%p*p

print(f"p = {p}")
print(f"a = {a}")
print(f"b = {b}")
E = EllipticCurve(GF(p), [a, b])
print(f"Number of points = {E.order()}")
P = E.gens()[0]
Q = s*P
print(f"P = ({P.xy()[0]}, {P.xy()[1]})")
print(f"Q = ({Q.xy()[0]}, {Q.xy()[1]})")
print(f"Expecting {s} from attack")
t = launch_attack(P, s*P, p, a, b, debug=True)
print(f"Attack gave {t}")

