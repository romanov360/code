--2+2=4.

nth_rewrite 2 [two_eq_succ_one]
rw [four_eq_succ_three]
rw [three_eq_succ_two]
nth_rewrite 3 [succ_eq_add_one]
rw [add_succ]
rfl



--succ_mul

induction b with c hc
induction a with d hd
repeat rw [mul_zero]
rw [add_zero]
rfl
repeat rw [mul_zero]
rw [add_zero]
rfl
repeat rw [mul_succ]
repeat rw [hc]
repeat rw [succ_eq_add_one]
rw [add_right_comm]
rw [add_assoc]
nth_rewrite 2 [add_right_comm]
nth_rewrite 2 [add_assoc]
rw [add_comm a]
rw [ add_comm]
nth_rewrite 4 [add_comm]
nth_rewrite 2 [add_right_comm]
nth_rewrite 4 [add_right_comm]
nth_rewrite 4 [add_right_comm]
nth_rewrite 3 [add_comm]
rfl

induction b with c hc
induction a with d hd
repeat rw [mul_zero]
rw [add_zero]
rfl
repeat rw [mul_zero]
rw [add_zero]
rfl
repeat rw [mul_succ]
repeat rw [hc]
repeat rw [succ_eq_add_one]
rw [add_right_comm]
rw [add_assoc]
nth_rewrite 2 [add_right_comm]
nth_rewrite 2 [add_assoc]
rw [add_comm a]
rw [  add_comm]
nth_rewrite 4 [add_comm]
nth_rewrite 2 [add_right_comm]
nth_rewrite 4 [add_right_comm]
nth_rewrite 4 [add_right_comm]
nth_rewrite 3 [add_comm]
rfl



--mul_comm
induction a with c hc
rw [mul_zero,zero_mul]
rfl
rw [mul_succ,succ_mul]
rw [hc]
rfl


--one_mul
nth_rewrite 2 [← mul_one m]
rw [mul_comm]
rfl


--two_mul
rw [two_eq_succ_one]
rw [succ_mul]
rw [mul_comm,mul_one]
rfl


--mul_add
induction b with d hd
rw [zero_add,mul_zero]
rw [zero_add]
rfl
rw [mul_succ]
rw [succ_add]
rw [  mul_succ]
rw [hd]
nth_rewrite 4 [add_comm]
nth_rewrite 2 [add_comm]
nth_rewrite 1 [add_comm]
nth_rewrite 2 [add_comm]
rw [add_assoc]
rfl


--add_mul
rw [mul_comm]
rw [mul_add]
nth_rewrite 1 [mul_comm]
nth_rewrite 2 [mul_comm]
rfl


--mul_assoc
induction a with d hd
repeat rw [zero_mul]
rfl
nth_rewrite 2 [  succ_mul]
rw [succ_mul]
rw [add_mul]
rw [hd]
rfl


--zero_pow_zero
rw [pow_zero]
rfl


--zero_pow_succ
rw [pow_succ]
rw [mul_zero]
rfl


--pow_one
rw [one_eq_succ_zero]
rw [pow_succ]
rw [pow_zero]
rw [one_mul]
rfl


--one_pow
induction m with a ha
rw [pow_zero]
rfl
rw [pow_succ]
rw [ha]
rw [mul_one]
rfl


--pow_two
rw [two_eq_succ_one]
rw [pow_succ]
rw [pow_one]
rfl


--pow_add
induction m with b hb
rw [zero_add]
rw [pow_zero]
rw [one_mul]
rfl
rw [pow_succ]
rw [mul_comm]
rw [← mul_assoc]
nth_rewrite 2 [mul_comm]
rw [← hb]
rw [succ_add]
rw [pow_succ]
rfl



--mul_pow
induction n with c hc
rw [pow_zero,pow_zero,pow_zero,mul_one]
rfl
rw [pow_succ,pow_succ,pow_succ,hc]



--mul_pow
induction n with c hc
rw [pow_zero,pow_zero,pow_zero,mul_one]
rfl
rw [pow_succ,pow_succ,pow_succ,hc]
nth_rewrite 1 [← mul_assoc]
nth_rewrite 1 [← mul_assoc]
nth_rewrite 2 [mul_comm]
nth_rewrite 6 [mul_comm]
nth_rewrite 1 [← mul_assoc]
rfl



--pow_pow
induction n with b hb
rw [pow_zero,mul_zero,pow_zero]
rfl
rw [succ_eq_add_one,pow_add,pow_one,hb]
rw [← pow_add]
rw [mul_add,mul_one]
rfl



--add_sq
rw [pow_two,add_mul]
rw [mul_add]
rw [mul_add]
rw [pow_two]
rw [pow_two]
rw [two_mul,add_mul]
rw [← add_assoc,← add_assoc]
nth_rewrite 1 [add_comm]
nth_rewrite 6 [add_comm]
nth_rewrite 4 [mul_comm]
rw [← add_assoc,←  add_assoc]
rfl


--`exact` practice
repeat rw [zero_add] at h
exact h


--The `apply` tactic
apply h2 at h1
exact h1


--succ_inj
rw [one_eq_succ_zero,four_eq_succ_three,add_succ,add_zero] at h
apply succ_inj
exact h


--Arguing backwards
apply succ_inj
rw [succ_eq_add_one]
rw [← four_eq_succ_three]
exact h



--intro
intro h
exact h


--intro practice
intro h
rw [← succ_eq_add_one,← succ_eq_add_one] at h
apply succ_inj at h
exact h


--!=
-- apply h2 at h1
-- exact h1
apply h2
exact h1


--zero_ne_one
intro h
rw [one_eq_succ_zero] at h
apply zero_ne_succ at h
exact h


--one_ne_zero
symm
apply zero_ne_one


--2+2!=5
intro h
apply zero_ne_succ
rw [add_succ] at h
apply succ_inj at h
rw [add_succ] at h
apply succ_inj at h
rw [add_zero] at h
apply succ_inj at h
apply succ_inj at h
exact h


--add_left_comm
rw [← add_assoc,← add_assoc,add_comm b a]
rfl


--making life easier
repeat rw [add_assoc]
rw [add_left_comm b c]
rw [add_comm b d]
rfl


--the simplest approach
simp_add


--pred
rw [← pred_succ a]
rw [h]
rw [pred_succ b]
rfl


--succ_ne_zero
intro h
rw [← is_zero_succ a]
rw [h]
rw [is_zero_zero]
trivial


--An algorithm for equality
contrapose! h
apply succ_inj at h
exact h


--decide
decide



--decide again
decide



--add_right_cancel
intro h
induction n with c hc
rw [add_zero] at h
rw [add_zero] at h
exact h
rw [succ_eq_add_one,← add_assoc,← add_assoc,← succ_eq_add_one,← succ_eq_add_one] at h
apply succ_inj at h
apply hc at h
exact h



--add_left_cancel
rw [add_comm,add_comm n b]
apply add_right_cancel



--add_left_eq_self
intro h
nth_rewrite 2 [← zero_add y] at h
apply add_right_cancel at h
exact h



--add_right_eq_self
rw [add_comm]
apply add_left_eq_self


--add_right_eq_zero
cases b with d
rw [add_zero]
intro h
exact h
rw [succ_eq_add_one,← add_assoc,← succ_eq_add_one]
intro h
apply succ_ne_zero at h
cases h with 


--add_left_eq_zero
rw [add_comm]
apply add_right_eq_zero b a


--le_refl
use 0
rw [add_zero]
rfl


--zero_le
use x
rw [zero_add]
rfl


--x<=succ x
use 1
rw [succ_eq_add_one]
rfl


--x<=y and y<=z implies x<=z
cases hxy with a ha
cases hyz with b hb
use a+b
rw [hb,ha,← add_assoc]
rfl


--Don't get this one, why did it split into two goals?
--x<=0 => x=0
cases hx with a ha
rw [add_right_eq_zero x a]
rfl
symm
exact ha


--le_antisymm
cases hxy with a ha
cases hyx with b hb
rw [ha,add_assoc] at hb
nth_rewrite 1 [← add_zero x] at hb
apply add_left_cancel at hb
symm at hb
apply add_right_eq_zero at hb
rw [hb,add_zero] at ha
symm
exact ha


--Dealing with `or`
cases h with hx hy
right
exact hx
left
exact hy


--x<=y or y<=x
cases x with a
left
apply zero_le
induction y with b hb
right
apply zero_le
cases hb with hc
left
cases hc with d
cases b
rw [succ_add] at h
apply zero_ne_succ at h
cases h
use d+1
rw [h]
rw [succ_eq_add_one]
rw [succ_eq_add_one]
simp_add
cases h with c hc
cases c with d
rw [add_zero] at hc
left
rw [hc]
apply le_succ_self
rw [hc]
right
rw [add_succ]
rw [add_comm]
rw[← add_succ]
use d
rw [add_comm]
rfl


--succ x <= succ y -> x <= y
cases hx
use w
rw [succ_add] at h
apply succ_inj at h
use h


--x<=1
cases x
left
rfl
right
rw [one_eq_succ_zero] at hx
apply succ_le_succ at hx
apply le_zero at hx
rw [hx,← one_eq_succ_zero]
rfl


--le_two
-- cases x
-- left
-- rfl
-- cases succ a with b
-- left
-- rfl

cases x
left
rfl
rw [two_eq_succ_one] at hx
apply succ_le_succ at hx
apply le_one at hx
cases hx
right
left
rw [h]
rw [one_eq_succ_zero]
rfl
right
right
rw [two_eq_succ_one,h]
rfl


--mul_le_mul_right
cases h with c h2
rw [h2,add_mul]
use c*t
rfl


--mul_left_ne_zero
contrapose! h
rw [h]
rw [mul_zero]
rfl


--eq_succ_of_ne_zero
cases a with d
tauto
contrapose! ha
tauto


--one_le_of_ne_zero
-- apply eq_succ_of_ne_zero at ha
-- cases a with b hb
-- tauto

-- cases a with b hb
-- tauto

-- induction a with b hb
-- tauto
-- rw [one_eq_succ_zero]

apply eq_succ_of_ne_zero at ha
cases ha
rw [h]
rw [succ_eq_add_one]
use w
rw [add_comm]
rfl


--le_mul_right
apply mul_left_ne_zero at h
apply one_le_of_ne_zero at h
rw [mul_comm]
nth_rewrite 1 [← one_mul a]
apply mul_le_mul_right
exact h


--mul_right_eq_one
-- have h: x<=1
-- have h2:x*y ≠ 0
-- rw [h]
-- tauto
-- have h3: x<=x*y
-- apply le_mul_right
-- exact h2
-- rw [h] at h3

have h0: x<=1
have h2:x*y ≠ 0
rw [h]
tauto
have h3: x<=x*y
apply le_mul_right
exact h2
rw [h] at h3
exact h3
apply le_one at h0
cases h0
rw [h_1] at h
rw [zero_mul] at h
cases h
have h2:x*y=1:=h
rw [h_1,one_mul] at h
rw [h,mul_one] at h2
tauto


--mul_ne_zero
-- cases a with c
-- tauto
-- cases b with d
-- tauto

-- apply eq_succ_of_ne_zero at ha
-- apply eq_succ_of_ne_zero at hb
-- cases ha with c hc
-- cases hb with d hd
-- have: 1<=a*b
-- rw [hc,hd,succ_eq_add_one,succ_eq_add_one,mul_add,add_mul,add_mul,mul_one,mul_one,one_mul,← add_assoc]
-- use c*d+d+c
-- simp_add
-- rw [one_eq_succ_zero] at this

apply eq_succ_of_ne_zero at ha
apply eq_succ_of_ne_zero at hb
cases ha with c hc
cases hb with d hd
have: a*b=succ (c*d+c+d)
rw [hc,hd]
rw [succ_eq_add_one]
rw [succ_eq_add_one]
rw [succ_eq_add_one]
rw [mul_add,add_mul,add_mul,mul_one,mul_one,one_mul]
simp_add
rw [this]
symm
apply zero_ne_succ



--mul_eq_zero
-- contrapose! h
-- have h1: a ≠ 0 := h
-- have h2: b ≠ 0 := h
-- intro

-- contrapose! h
-- intro
-- have h1:= mul_ne_zero a b
-- apply h1 at h

-- contrapose! h
-- cases h
-- have h1:= mul_ne_zero a b
-- rw [left] at h1

contrapose! h
cases h
have h1:= mul_ne_zero a b
tauto



--mul_left_cancel
-- induction b with d hd
-- induction c with e he
-- rfl

-- induction b with d hd generalizing c
-- rw [mul_zero] at h
-- have h1 :=mul_eq_zero a c h
-- cases h1
-- tauto
-- symm
-- exact h_1
-- -- have h2 :=hd (succ c)
-- rw [succ_eq_add_one,mul_add,mul_one] at h
-- have h2 :=hd (pred c)
-- -- apply hd (pred c) at h2

-- induction b with d hd generalizing c
-- rw [mul_zero] at h
-- have h1 :=mul_eq_zero a c h
-- cases h1
-- tauto
-- symm
-- exact h_1
-- rw [succ_eq_add_one,mul_add,mul_one] at h
-- have h2 : a * d = a * (pred c)
-- apply add_right_cancel  (a*d) (a*c.pred) a
-- rw [h]
-- nth_rewrite 3 [← mul_one a]
-- rw [← mul_add]
-- rw [← succ_eq_add_one]


-- induction b with d hd generalizing c
-- rw [mul_zero] at h
-- have h1 :=mul_eq_zero a c h
-- cases h1
-- tauto
-- symm
-- exact h_1
-- -- rw [succ_eq_add_one,mul_add,mul_one] at h
-- cases c
-- rw [mul_succ, mul_zero] at h
-- rw [add_comm] at h
-- apply add_right_eq_zero at h
-- tauto
-- rw [mul_succ, mul_succ] at h
-- apply add_right_cancel (a*d) (a*a_1) a at h
-- apply hd at h
-- rw [h]
-- rfl

induction b with d hd generalizing c
rw [mul_zero] at h
symm at h
have h1 :=mul_eq_zero a c h
cases h1
tauto
symm
exact h_1
-- rw [succ_eq_add_one,mul_add,mul_one] at h
cases c
rw [mul_succ, mul_zero] at h
rw [add_comm] at h
apply add_right_eq_zero at h
tauto
rw [mul_succ, mul_succ] at h
apply add_right_cancel (a*d) (a*a_1) a at h
apply hd at h
rw [h]
rfl



--mul_right_eq_self
cases a
tauto
nth_rewrite 2 [← mul_one (succ a_1)] at h
apply mul_left_cancel at h
exact h
apply succ_ne_zero