local Name, Private = ...
local E, L, V, P, G = unpack(ElvUI)

-- Details profile
function ProjectHopes:Setup_Details()
	if not E:IsAddOnEnabled('Details') then Private:Print('Details ' .. L["is not installed or enabled."]) return end

	-- Profile name
	local name = 'ProjectHopes'
	
	-- Profile strings
    local retail = 'S3BA3TnsA6c(ZP6BD60heBy5(njBjBnPSKhr5mV9z8yAisijwIIuniLDQCUT)TpppVbwcaciQSQmVv1Nt2v1LTLacelVlpVRXNvF(Ypp5HY1xVyzb)RBUD93MMxwSkFA56LftxmB9QpF1NN84MIPLf5l3U4(I5pSH)Os8KxNphpZk8MNP(8e8xot)5ZIEL(ZBXqTfVW9fLtXqC9IB4OFD(MT4h84dZZ3widY)5JlMD305fBlMTDH)tvwSPy70npumB6S8z3wWF2Q1tZxwuUvEN5l2KFfMB3)02BxmB68hxDtr7SmF1I7Z5ynnF2SILF(qoxw9iMilMLVC6MNWu4Ez6YNEZmSmx6)SpSUC70BXIC6YfRUZVglUF9x9R87NED567NUcljmMtUFb(opE)u8RlZxUelY7VkF7uU)GbpcZYI8T3oD761yp7HPFBX8T3(5ZmUOMV021t)2TR)8eUVTzB(QzfBMUP4M7lwTDZ0LRNDxXC(H4GVy101RkWGSA(6VTb7KB9ZE8f3US4MY1pUAoE3smxM(qEj(BCY)WMP5xDvzXxxi7h4R)5jFBD5Y51t2fBMUTmFZTYwNCMWTD8z5tE1613DFE5Dt3w8l44yXVY1f21A3FLNDk2iWG8vStJdERB39A8h3F16LBWR(421KiyEZ3j6vkx)TQnyfChNsvl3NLiRDRd7BpoD2ssoHD21puSI7EnhpllYlNUQ4BZUf)ZcqXWVapTMU9Phk4qobBa5YdU6XhWbWnRFClFO2pbOcxU4k)0s2G98nt3GL)0hwVHFW5fxN)4YTtV6gqX(WT5CMILOSptoHzyxEf()fc5IvpbkW1LGwUyZM8Bk6qFtgOTZU1t3XDNRYl9eLE(WPGreVi4OiVfgv8sZ5dC96vBX3A56s)Eg)VA5)1i)Vw()InppFE9lEy1lU52CU(MC25NDu9pYF6NcY(o8Ctd(OBYV)boPLhf0pxxcofquUD7Iv3SPr2Y2fGILFlS6W(9NNC65)m2jxdQOpp5YZ)a(fG0PqoQRzAIatZtF(SFqr(QFb7OG6mF2DZlx)qNLzKNYqwMrYYSIkPLB62If3C7w8Cg(ZLf315Zk(8KJlx8RF)l)F)y(CoT((xUetyHYF91xJfHqGuXJGPky1YfcESqx)a5gazkxWcV52D4sWuYu)ddf6qkR55LG59UfRcp75mEk2KbR9dtV6XTBXxqe7absLpnfFQpFwSvORWdUGSzllitijl)6dtZ3mvExHKSAm9eU(FUmyEMIQVsnfq5midfcJ)6ITpjIZMIXJ)QaPup(WdqkDT0dEEmBzo(3uBb(13dwSpp5eUnXn3pDW85NVAZNEtX28fl38jSjak9pjVsrZJxVnwXEDznHWX2mNjZLfNLytvj60pF9p40dShp9(8FPwsKjG3E66Yf3SyfpVWz4dlZFcsjN7Nl781izNCwm5OLF9JNqcTsrc4JLGizYDpbvdfDiDesBk8bc4o6xK9LVL)Km)G4UP4F8afin)jO5aCovcK6iyXt(IHzQif5sQVRe7k8V90Np(hCgRnsLMMf7uzQyUdynKta7nkBsItffP1jUul)nyr(TpFCQjY4uMS4iRnncCq43a5q3Y3jokllXzs1XjktS)3qf2GvY)j5g1V4zbRy)WPSg)PqBl8XyQV9XnvsKezVvh(ErfC)hm6C3Jp(QMNcl4BBLlflCSXymxmxecJHhsolX8pXLLzngxSwLzYm8uhZ)RFC5YRwxohhHnFPBX7ofcRbRALMn(1ebdnSopRCWkzRYkyQGeAVeVHVYMPAIham1tbRgjWA0FxJjHuc5lxCZQP3dLdlMsQhiauKmEfp3)gyyPoRkUWGvz9UNOAB7TGv9MBR1giF9D(LLeJWvbNan0Vh80I)g(dmpeDoKLLJp3afbhlFemkIKJVHLszfMmrRl3AMxSbh6q(OFLf8pfTVYzC3TH6J1kD5tBzYaYLYf40XdXS6WmQ6WSg1z9USFyuD2yEEb)Y5AazzJU4mTqHDf4dIJ1oxKnwzvoR2rkmBGMLMDTZa2Rk6PXv0WVNNqCfvZZxUHToql5IvG)FJSBdnipkyf57IX7f(GMx6dAFPpO7L(GXV0hm5L(GPV0hm7L(GaIWl9jFXNnQx8HJ6fF6OEXhpQx65ZwVnzEt4Q1nY3L)dGWbWOBuZwJtjGfzCaJEHY3aHYqzJj26s0zqXrSTsOmyrHUFoRQKmuJC1l9TL91Rz9900jinCZ2fZWp7Bl4JopNcwl9WxxUCneyCtV1nLe8StsbV2Z9ev6TRK86TSz5I7x0IYlQzcrdbRNpDFfDTsm(09)LMMFzItopai78(YY9AqXUc35KFqNnbAVxGISqz7TgFmruaFyE5ea5zo3QMvqLwFEYBo6Ydo50jtNC5bx(XjhEWft)WPF8TNC20xF65V(hXKsGap(J9H38HjHek75jj2jVzRxwBjf3iowGvFWSzyzUAB(YV)LpaSr8Fm7j)tCavi2GvZ)Yk)VAIx3EK)F969AkZZUCMC0BF)rND5)Wtu1FWtu)XZ)OZs9VlZsA0uX1VOT1kauW0Db5608RwSCX2fawlpAPnIf3x9V6iWXpdoKtGd5V8q(5VIQJoKQAixXdCrF2pOjhtUNUpWM)AXlDGu(d6KQLeEskNS2Zh9zuTHCXtdC4Y0PBwL)W7ejo1gXFSZgznQSKyalvda0uYNPsY3g6nNUWL8Oyw14vO6dJEYdQb90HfFXk)BTE1YN8Gd58X70hkFFXQRx)CUQt8C2ldfR8OEP)EloQwUczYPetTyUZH(pSxgPiry76hKjUxuc)Bc1Iyz(ACOCFfIiooxupovw6DvVHV9h)qrjLH1UDD9IFbyl3Ry96XRvgU8kp17haWCtj6Uk)L5nz1pUEtXXXy(10bL1BLng5n2(PyK4NEnqt)P3xmFr(NoMuzFQ1oWxTD710LxcPrlu365kSTln2LzsDoAVtInHwJL1oFN94gSBUZNVfMkpnOjgbRMnnM)88WJBa4wrv89VaTjhkKMF)l6oQERPuB2RRMxcm3j))rpNP(VE13)I83m)xYFO)V669itfjB4MbjTgGyy6lC2Fk9aXQnqCJFMCvGdEIB3eFUdVPFOC9FdCUVdwFTP6qCsTTTFs(PF8KxT9M8kBGcp9QjSoTYpyD2vUQ6fGvw3rN8sd)Hnr7XVCbCnYMf3i7lO8QA3)2Y(2818l1Q)XnLWgmXIRRQh0bMOhw)7UI(sclRkp)1LeKdAhUzXo1g(t5bBxzhBDALowffdrMANxEPJRGX(nMr)nDpWLDLvpE)vESzv21PAOl7Xg4NYdrT(9V8)tfz6)VbScvh4djW4Zto6(h2(u)vDOeLGnGeJnjYMznzXzrjoD7gWi)gZO)MAYIAkOxYKDhA(lZlVPGUI9y6MYp9Xt(HgaKTV)TG3zPhDy7BEC5IIvZ308Ev)7tb(9F4DTVq1o9G7))MzUxTUr8GqjxXW19DA8GDJ6V(YwJbTuQIYwDkvKTs2AGxFdCyxl9E4s4WAuixoSYUITFROyvLNRy4TM(WMQ4B1U83u8qEjuOxwZAD)65flffPp(au6nv(3as)dflHY5dagVdlLyIGFFr5BlXN4vVxt)y)T2N(NzOC(0r)V(WbNn5KZpls)P3C(5V5G3mb6JwopVSm)tV(8tFZbxCXbay5hN8Q711FVWit4hZaz9(FqZJOQFP2hzBJZoAH4u)89CSVqmwqwJYv9(mnrsX7LtxgoI0gywPcOS8o5mrCd5pyTVYLMb9JXrzgAwvv4co88lV883FXjV9DH(Vvc9yLa8gWsTtVkUObP)QTHoaJ2UIR3Hy1dq7N65IZPZPXED8Z5piiGPrWbcvRm9JmgKoEtfeKVT4bHccYWVI(uIiUUQNXPDTtS6xbOXs0ZeFoo7XsWHiY4BD4wLVPMee4Nk41hw7i2k5PbQU7kcLrb9)QjIomiVcNyTUKb4UcF0L4NSP5zFjbQkeHV)iZ24jAzq5kEyLWbF4RUXhn4GDQUBHYEMqyl(Z8Yko9RQ59VAxcFb366nlMLV(F5DCVN6u4e66zfyQrr(x9N7ENdx7ycbDbmVtIL6kVdgQ4X6t32zl5B4N)q(d7eAYqjp(W7HLvsky(ttujzoTxkTvOnMTg8GDo1vDITxsaTXejisvO)oons7I0PPQKuBmSxJJzmpnLOdP7lfyS4cuRODF2rfasqSgg2NpLHgzND5N4UKpWCvBUHd(jV(8ZM8Pto7NMItHflNEjwy0ZD7XLwn(5Vg7lduRyz6aoYN4ghmge9JwWlqnDTBRhjSvqmooAJCUyLchV6QdwsFQujVkcu3jPkT75j7ptzv)z0P(dj6uh(NrN6pJo1FgDQ)m6u)z0P(ZOt9p9Ot9HdU8Ylo5WpE5r)reIQfBE3I5ZlA844XdA))KTpTSnMlbbOQoikhNaBuZIJZItaYJOmxG)AF9ZF2(sw4Ht0R(nprhn0p)rmRBIwv4o74rUQZcO)KmiaB7S2(hCbS)az5xi)zuS(hmkw0IU)Ljow)Zkcwpx0a()KbZ6VZyQ8hE8Uo7hyqOdJrZ)mIJL63CCS(V9oSD3yRou8ohjMA7nyK)FIaTnySd)JmcB9ck2)2ZhTbpL9VTWUTBm8(VHXC7IFFJ52UHW7Fzc322InBVkmCz)ZoCBJeFY)GJ5wN4m)p)yP1nfd(diWujGertNtJ)lywsR8mPeyQ)5flQO)mwu)ltSOC)3Hyr9phVX)NHC6FHc50H)EeYPGmz9FIbEcFDSXs8Sc(S)ERasHHCgMSZPxXbr10h(69ELaR6nrEvv0)FvfbXRQGt(Q2kjC8kNmAV1AO8bB2hJhEQjhH11z4ZvpLdxEKVQs2V)VyQ)lYQWMeuOKb5rNWrxviMGaxEiov31ORjfqS7ccazWkISP0MZVhuTmcar9lpxUaBReB(z2qHRtML)GqyWcFLlCQXXJMaMFndaf8fK9MzcwEQF5Xs5plGQ9BEsQbsX3LvIChWpVCIuUWxyYlxUyUOsOtbiZQb2xbY8VfucYbLfFL6Kkfqx1wL4DQoCxaTrq1dsxPVT)wsBzixfJkGO6(hQ9suAa3H2tp(dkjZiMTC9JaCJFJRDda6zURy1uW6uYc5D1nIwjPCuRluviPAvX3QlwuH(9YwYbLlTTUCvrEr8sjPU9wOF9wyiR4NQ5f5ZXCFQWKsVMP7uA0EYsSdgLb9jC2stHUDrXY5vrm0JBecJLDO39XZU8Ol6kt4vuzvfvS2vxUVYE4pdBOp58rF(QNv5F4lo)TF8Ogwen03zJttCvVKjr5t6ObEZ3FWBBFrz019gIDFNpC0L7)vEL8bTELw03Lx8XtEtZR1oLK3fWtv2O4HxCV)8Z(X21wZIkol8vEvZ2hhvXxPhC57(XZeWSdmzh71WhBYZDm1Bvn5Dh8(do7fSB0)49JN9JNbPC7USgB)7dxCYrtU8fEgpWN7TxC(h)Who9G)J2f3l4REaeKqp8o63ncWestSPd)6hD2rV))4LUx(MJWMFxUK6tzt17o2P27OXfVqIRD2yp40dEZjNn6SS)36OF68Fmyg6Imz(bxEVrOHb3CvSgErtXEhFnOJ62lm0T1fpK22Ksavw(DyDhBqqH77ciIR0lxNpFMVlMea3421BRSJeMgjW0V0Jn3JsVv1hhniEFJh3RxepSQ6HBHoOdBf7jMlVJyVxfNuTKtnvRv7qI7EvsA9gAnwfRzGtRxLvdhWvV3Ly2rUMTg3tnzAMOG5Glo6SdM(FC0PN2WjgIX655DS1hD1tV(c5unNTvprKTV0SoFmx2yITssAikRNyMDf(u)5QNqPj9LvB6nL3r1r9uoRgAL3qP(YQAqounz2r80oXdOj8pQDzfC1N0U6DIKSDKDGtmyHxiq6xfPYIBrbpKWJ46ZivwNr2FU)2lo6OQnVJJvPWOqLvRItbRP2huj66T4eLsBJJTrMuvMZ4ZHf66TuLlZgBSwvCMnrxfikw6bh9XlV4GthIIAa5h6gYKAItxsSqPm5OtpU5XsZI4QWlTwRC1Nq(F(q9RdywXIBUPOSUFs4Ab16BjhfZxSniGN1OAzNEyJywlr3kO)KqEbdX8TMMVDlHbUE(AFG0YNVqq(fxLBrnDwO8h(WA8l0664)CnnMFBtWOB8JFNEGtn0AMXx5)Yyy4SUwi9qJKaxuMw5xnT4(R8HRpq6g)5sBpAcS0VJl5baYM(kcFYNc)TFtvNwGvUi71hjuybDAJNMUS4M8z0jBPzUyDIXLsVuORtv)VHFtSthBYCP2iDCSU2w963jjYeLAtIssnvVZTm980oyBFQX5sYmz2Ax2v)5y8vjrJZ4a1GUYBE9)zy2Z9KLEZg2wznn7UkWWMBgSv94JL7GnEOTRlV52kBv4VW3iseBfAZiuPnBfMGm(8VOMi7b8ZNjHtkSpardp8oiS2fkvzx4tvHvDBr(91Ha95TLXRaIXKia99zX6aupKrwna4NEQDptzJtALt1xd)RQF4y)thBcuV76HyP)qt7qFjq7XdQEg8R9Fw9ZGTR7ZI1wARKYMNozKfN21U6Qr)PgEoyFP24GN19CyZ7)4XX)gqYJb)5o729Pd2nm6u1U7i7(kzp38PbLzA1Jhp6j(opRlj55aP3)SjG4EGjsx8UN5svpdD6odT9zE4EJSo29m7478WXph53opD7gsZ0iD8N(zjT3HmmoBmA7DF2KONBI0)XdE6Xf70NWsfPhFtVl3wIA0zEV9evKz8dNEdQEuc1EKhSG0gFJUVaNeZZT11BOdE4bOP3Hm18YnQfZA3Zmr6jolw9cTFfYdIFgEL(hYT8k7ZIZZc4b3LTAxtfRvBF9Y8B8(HDhf5xTEZMa3uUz2Tf3xfo82eiRUzgsyybPsw6U5jkMf2AWPQg7DK)MT1uKWX7bMcteJ3ow0EBroHbmCOSooHvpuMjkYQZaeRkq3sKWZuaPzsuuSjc)Lm(BsBTpiiwdvq(T6044KuhWDfRfmz1q(1PjggbeNL1YxW3a766ig8jw1tkB974xJ(yDggrwFJR7Rl2SU8L4iFXfQ0ZIdeafyh3PNE45N)JFsYxh2yl)HpKFtXpOQdLd7iFffRQWRkJBM9vy)iuQdWhg7n7RABUTit6BKyT55TRpybXv(8b8SKQmbIjeqX3)Ye2)hRdHGh4MpaF)UC01nScjDjK2kjPGNwQToha17p7F23j)rtaVMwwSe0AFTWN9Cv)uASK3AgjUo(4Da0ZBE8kj4FTHL7W2hPkSfsGrMT((7ZxnVQTMYNy3i2(YdaE1t(S5ewDEu2eO5MT(xq0IQSX6WMpv1s2k2CT4EU6UVy7TRN7RKe)w3OfWS)xxzHuvMh2sn3IbhCDoxAK1PnP6OuTXZbjwPFCQrd8dGrmf2zdcHaYJ4eRYyvjW0QyvDHkHv0XoyovKkX6Yyv3MK5hT687ODBSoIOtUWxGkkkSFYPIxeQcy8LH)JddESTDwkHY8s75uP0G2152(De2Nlwt1wG57AWv2FDvvZC9QY13vrmqJxL8TQy51T5jzRPZ1JJeoZM0S5W2izizIVxLGF2XFyRR6MxC1JxFnmA8XYhyQX4)xBwS8RmP3VwsINLpD9cUmMNxE36YC2eA9XYAYnu8dzfwVusvJjpvWQmOjUvqzZC)oZnlxFv(B85Sw1ePSyM3jd(e3VYyX2SqOkRkWVB5IRlMwLjGEvyll(QKeY(it5z23iDqxXnLtBd2yJr7mddQQDJTEoUQo)zv7AUYtd5R((x2EleW94kPN6Yu3awSNs(K14xuYqwjKNFEYD5)6VMxM)Vx9g3If)1WCzgokymoEpMNqRXAT4QQHjtX8By7TvVbmM(MhlUIXuwYwaqpdzLydaCxF)lRV(7FzvXYT3MxkAkLXe4wXsDdJiL)jKb6xZ)pZxUO(rG6ASdbt75VcuCxtOasoqeLXIt)gmdwCx9SoV8RfB2w99tH8Ap9v5JZGT)49Z)1h)6I1I)EKDc2oDZV5Eqj8l1RtfpGFKoMXpej09FZ2Uyt1MfmlBc9l967Q3RkwoNFr)RZuMpF56z1BTz8lu8l)YQ86TnlBuVp8WTlkxVQAFIYGFiF7SB)wr5D17DostU(QRECz78LiCGiZkxwjVktbFol(ktEG8vyNeBaFlVCoME)6M7YlR3TtIL0hA18V)LVTaK4F)lxNxucTt1ZSumlURy5Fz7Tp(R5ZR)H8mA1Jx9xklU72gsi23Bx9e(URMxMxDAilDotiDdKIwaQVIFbK6l8mdvZcx1tbUQL3K7DXY3)YSBZLCBS6HSvu7vkMOgJnGJnN0b1pdvHuSDbwoZl(6AiCQMC272BiPPKTxBSVwY(Km7yUaSyvUb9lpKfTTqcJlyHxwSTOQ2AME5Rp)qFqQxC)9E)(kW9ywxXuUr8AKptIySsRJwDdN32gyPFdCyqUXB)4jN(MWr7ri2uCWZI8Lv5D6HvjBeRWtcWDtGh98D(8npTAwvcRw(AjLM8z(S)lktIPSXwFdde8s2B3X3GYyKe8Z)VlwnJkoPct55FaY6Kw0(gsnLalCuC)RA4WAYNvqZ9FJQ9NQqv3mDdWH3IDlYdzc6cTrAM6EqbOpFNepytW8vzsuBNPVv8w302q0Gbjr8uiaiV4JnFpuF(urK8sXY5SKW966TzUNx1CWHmmQ3Gs9HSQ5SRUF)IvvjmWzwMSfL5ymRYk56(TD4pJUtsk4WLRH0UnB)8X2uBQtPHc9mxIr8apBZa3TGhrIgRT4C52f4GR8P66(KiksDXPPjkamibykYIAXXdm62udWha89wxsv2mvvjOYRcwALbsOCCesJBFvSTdSgMyxIftmNQ5vn1Vk9NBK1QXKnYzmbVQthdaTPgIXLMew)Q2608nnnor5GmGuxQo1f(QMml(zkTkth(QU6xngaJse3cJVswC4AfiHsvotkM0(WuyD1vuQyUtIvhHFNjlZytvQGVAQrHjlugauw0TK1VAs9RgtXK4)1H9ii6O9vX8Xbj24iWKkrZS(vtRH7LIttRk1cnjaGFA7RcQzdwVjzXXWqlFgPARRdv5vJzyvY0shZ2yd(QSL4GX0LgRyJNq18QQOMzSdM0rSIw25k0bOmzt0bGpb9coC0jTVBn9KdanDyfNPGvjPrHzGoiKCrGklJT9cFg3zAQE1wUwHIjbuEjjq7s4Zz6(CXCdiITwdqMz0TpNT)4naRrDDRg8CS7RfZNahNMWVBC)NZ4YalHlkfhkbpxsNNlntXaFrq32eJoRDVkT7ZfzZmzqYHZHD042JsvwNNdRsxsg00LytCwp5T8C6OUs9Whe)xdofXdh(CQUphZ6FqgHNsNag42NR75bggqHdUkR2AsfdpREotV5NocZnJblxWF1UE1DppCrr4ufec2yY1f8CDppKy(OInQyicpk22(CDppWAfKtGbZymrPgD7ZL0nqXUSxL5QYBrMpZqWiv0FfvnbPJEZXWSv3v0Qt7SPrE5zgLQA(wlAnDmjR1ulj8TsXjhKUagI2zxVf7qFKwjMn7D6m8KGWYaUPG9KUBXjzGgnYOIGmTmJPvMu3D4uq2zC8)cRgDbYFI7rOKYgDbOpPyDVaJqjC1pgK2G9xikZHtHSK(sZAEmia3rUwiBXzT1pw7Hs0UNjqTA3ZKikCkdCeXgUT29mjAuTDXuBfKdRz8WHvVTsNgEedNwHKkJmq(aHKeovptNX0WbYwK)V0Mjz2OtsqlajqqiBcyFtdfDdOLX8)aXEzGLChvYvu69)K7qgzHguiELQqIYCbIC6j5e4cOv8PubM10su66liXgbi5anaz)tgJmstsYu8bHsKNHmkcOcIaNFcOHGmSriJaolNgm9XrqvcJ3t9J1tOjyNHyjqbdjRkrvM1fQSRv4fGEIPNce6vHyUlvz6askII7cclowNKan6XjW0tv8VrjfugGbsjGMvGVXnIKcMZezwDkWDKavhPJjPalifKPaUBS)OAr009iooY4FMO4eCcMnIKcOOLI0TqEcFH0roIbogJLZFi0Pw0(ahXqZPdCBqprSgsksh7igkybTGllML7TxGs8(otC2OoNjauhuQAbhdSfojoQ7zIwpoW4uOKpfKxakjiiJBbbLKLc(VuOeojMBjnt)AGX84JYOHWAEuf4LojgwwfVht0K8U)HhKoILlGxKW2(sQX1kGcZKuqTduvGRi256ZZcuByTcWE4)a4BgtWRIZx6IVOeJj2gOdQbymi(JGCmGtHmECN2f7F1SuUe0PuUOoU9Rg3uXHq5Mk2caFatOZ2(QdVZVl)oKy4WMe2kX(MUfgsxIbGvaw5R1mrIQ78z2b43v0iailhY2m6aWa953nqUhqH40WGatWKtP6dUqGdAsuzTLmZqGwb2wy0cKaOGXMbaJ7l5vb7py1HazHoxW41dKeOTaAkMMJjUopxpqRPqenOgW(VH1Mw7Z1dKeoAWZcApvSZ744QNlPNqiGzecdu2mW0fyxrpqRwk0h8Ayss3CPhf0Qbu8PWMmOBiXgc2R75HfgYGJvaRolTdXspqRyNdBDzPgctprnkOvl7kxrmNGCKwqpgOvk4JS3W6oIDmAmqRWsydmnNShwCqpkOvaUHIsbGjiFGXOVr2qpJissPPQrGZcWRIshb06XqsdaZft2tiAlPv)LUhQkW9qlBPXxUk8JD1FzIhcQRUJWsGvfgBAHfLaVFutIwv7fb9E0GLG9sfLmcuSuD7iAWg(RSJgSyjrPHCuyUDCASzmSUXeEk2MWJcjZMraPqcIyQfrZ4w62rqwn0POSxrSR7iMcwdddjXbgmwl2gO2TNykGrg2bbCqj40nBuXu6miRivAnKrHsK7lMcQst4vFfr9BcK6P6BLrKgyMGHUzDfIQ6V1dgwG2haDGDvjdqMOhImX0vNkurbryqZhiYv6SE4CS7HkbkNGoLyyUqCuQlqhyplIg8JSlohQwJDjnhSZXAgJkHHPwHZglKasZX2fE)aRBOcPlwcyNCkm(gK2moSv7E7fFhWQM5IatbJJSfJrGVyGTq6ikmvimLFt0U7fd)H3LJbKEW8drWIloZngMpOmGklW)bKvk1iy(syXdGjh2YGWNaOH9W8bv8GfmgsLH5Fg3yy(G0PmhBRVj0bq2rW8bMEDsKuWPGStRgbwpS7IEnbu7AyxTxCxxOHzdCCM1ZiYuG6h4ja)mDrwpPDjJBFg05A9OxX5sCh7ZItbsgqYIFLZN0PDDzQMUScu0AMuQMqKHq7iKBRPYxy7GBKJyh1dPtjYE6kY4XekselXXkaZHWhmJDeZotlfhai9yoBh5igGkZYSmVd4JNfnMLBq)zkulhbuvgD8yhXdVTVZrmTZbuFraVsm0tz2vuvYqwKL09igysXChdJfg3u7RU6J4X9kEI4iFn2abEY4SSqNmdOravCkJVDfRyNJ4yXlyaujWCd8Bbjgtc05d7XbyBlzSI6FedIFGXNuxyFX5h76VkHbc47k6bot6oC2hZKMMwpIZGe(3cEvqMrPlgyKmz57tki7r0xRa4h0oyuHEfpjYOfzuasJvTd4FAqc9qmmOrfPCbKZS5OsLr8)JovPp4FyELI0bGIrY2BDRDdW4FaeuXR7rihZM24F1AVINasrcUNnb5Qatu)QqpH1aCsGrkPAh20XR40x7kyPe1(Mj(cowxd4odlbE)BGFrAGxDJ6bmNbejnHoKVgyUzinYWokQKfcyXbQx91GE7MONPXikQbljECVDRXEky8PlN9DPLr82DMkIUPhFDBAWwqpdhOkyCaGDmqw6AbChGeWmK11DfHIfg9csmTYfgM1teQEChXbs5iX6zyYQjnmkoyJfwtQmogxLm)qM0X6An9Lkd9uSHEbjuBk5aSu0BeSCpzhgmyBOkJsFmmqJzMaXVAIZIMHIvtS2UR11mVRILoNMc0E2QKSIQSsDogODSuGHbbMm1DdF4TQDvNAjoHygAT4ipIGHSAgIetGz3A6fYo6b6jRfCH0UzigdsRuJdhfMwJPVgYJZCr2XGJcHAydeFrisg0HMrTAgm20nASWnWcXngCuhjwTAmA48Usn1qwnta34uH01PUqNO3J4xu45IO91yxoaZypIFyJKvCHkaubmtJB1muk7IGUCgAWNXQ5uyCaat50E13TeE9d1dfmb5ByFKaXBr30ZQzyqimU1j(Na2T3QPONvZSxEeXiWc8eG6SD86z1mSGkHUIYyzO5mbwL2hZndUk5rOZsdOr7B1Cmb54ihbooc8kupRMHzqzP0h2XqE8GMBOud5xvJQRzPkgGIuXJdXU((W75WDdvAPvoXUJVPIta)plynOZuB07yPkSJ3agrCycPj0t0TV6WtMqT4WMf68DkMa6Pc)QGXhGYaxMUUm5g0wfM8nWoo6axG5Fm3UdJyDS46OxgJcn1SNafynavWWykG9aZicuGMrOtZymAX786XSVvRKupecrbbCGFvY6ZGb(vqfbqqGwpzubkKVxNckjnynmjJjqjMhImAvwGqoigFbARYgsBvx3BatvakkINKMlQm9CVrYZcheiK1QikqneoymDEj2q0uCtLu9UWbZsGebawXkPgu4RIffeBWBLM46402jjja2gg3WmM0woM9)Ty6ywdWEnJJPeCSEh4GuEpwGgLpGXjbk6GyGiqthrNfe5s2XxWezRMAYS0xwU0aYxhZveG71WK2iEx4G04oq9a7pJiCQSWxLz3dMr0QEZqWb1qzhMuqaVHjfcF1KQTj8VzBlcYCWmiRpHjqKJ5jdVFc0Zzfc8AnZ2uj1uWQX5076mgiFplIOJbkcddTgF1SARAhGuzq)iNer7JCSkeTJ6h5yiof)FGmh0sXbB79HdMan)aecexf5Sb(fSpCq8aaDEk02j5fWyAetf3LglcKIRcjLBi4GqCJHaFCnvWB1Z1ZuWujJq4fYUMauAFUEAeHflGFfN60fpb260xJiHYBD82rb42tZgtJijiveIqgpsdDTypnIkEp6zabdGGeRJhvJykOOmaRiWidcVr1iY6yifIoLqvzBTcTVgrRd2IaLmSx9dOz6X0iMsQ5yjYrG511AJCp)id9lXStsrNBPZcop6N8dGHZWkFLqkJnd533HsXbtxbJKJnkHr7ccIQ8HZlpWLjStHLq)8RG0rvu)4H1SKGog6iBNlfQwnJ4HJHNl76eRuSvJJqsF3jPe21jwqnqm)MX6aKuX9vRXSecs(aELOGCxONhoaAlJy3bZwJm3OE4WejYEYSwBw2abtEiLvzDDYkmKfYlGKuJIjeL6Lc6rSRLD5ndbwRcC2ymD7Bgeu6yWW9kr7ORIEhogGjvckrvGwJu6E90eA)ceEP31YkC8Z0VZqlnQo1QFvg(wNwr35AQUb2666c61qAlJsAR3zb5KHOvnHbpsZuOzhDvWyEiKHPpNI8kborq8HMLGOLSMspg4idDxhDpRsY0Xrbhz0mmdK1UkGUdboI5Zc0acG9mjauPJ48slJpenJmkQPZ6nKUfO5kIziiakqTcbYA7zTfOVZyu2O(Q0qRE6htmC(rGGq0nJ(Yy6wiCSuAPNkJPn7aKVg3qGT66SCglz6QehdVMVyVcC9MwnU7vbW8Se6NCRlYF0v7AGupsiOZgyRBdYvdbSLTiGmnrHeX0XmmFjTkiOWWM9xDEGy7c2sbkBabgsDysNf8QmvgLOvrsTS4DDnGjw6WfaXGK)PbnE2e62amBtCP1(JAOytn4w1UUHfBgPqGMtIMA2yi5tzp)H1wa0vw7ZZbiw5LigTbMXwdYPuJGKhy9bpeVun0sD9ngXAcJLfuTrV3K(mUgaCQQiX9zSiXTzJhPkA8TGxeiKdYoX(UgapfG4I1RdWicnLVN(cAHEmT8cwG1bqxFRQGfgWgdsgPmb2O1hiuetSoqKQO5YbEwPhqOyYbjEKWuFJKmya1XohiVjOkOeneRApGqwO3dl3i(KmRwhdiethlQyeOnLmQASaQZ4YaHGgO1f2IhMDN6(Rdcxc0a0jlbHzTVRbYWknHWRyoQgnAa1D0ri2uAbJllmbm6bekMo(uLQTWWag08bYlp1qaCm9vMIZ)ywrA0Z7QFBaCemXuZje8qxLnAeltylWba3ujARASiwo8Cz3KVJPNTLP5UjnkDuzhogYfIJnYj5kYik6aucCsBSylK(32ocahMP0mxVs1zuu3yjJdK1tR7XrnZlb7EswY6C4mRNccW6sSgysZeSPxuKhx)qg2ZyD8KqJPI0bc5HauUXdRATekZortL(PtZSCZrRDIK8InwvPHNQ6aVfJoLjipb3jXjhyo3XpedOzuP7LsA0aVmMpj07z9DA(ZevQeINuS(gWwmbAgzYIf5lwaOfYP3vZykrUQ5ohKdf1w6dNXsAgRQoUjNX4a0jqMFuQvYpppyUZWs(vrsn00LA9mi9)vGQEGCmEWf7UaXGQDcwJb4ae9UNXlvCSILeBnzmVu5aA0yStfr3Nyc8zqFzPAtMIFY04oQN7PBJUKNU)hgBK66OtONUno1yzvKXBzfvGBG19zgzvqOtmTXgYncqm2z7ILUkCqav7BKpJrpStK55jS3jDmJ8zYmMYCfJLzywyLge3pzNGiVegIndMNJ72Bi4oHEca6SuSRqmMr(0OcdHod4nv6SCdQBJUjI16co5ub(GSRUnwJuVs5ri1p9WsyKD0KMJGcshtBglTekoe0C6u)TGZGM1NWOdqjR0Dmvc6Cd5OBTG9MUFIPbOzmZ6tKaxYWqbRvcDhtpZ6HLAzeWcJorMp6OvpxYUSnmaua7FD(Koq6HHLL6vW4k53K1lXXygpNybUyO0mZmKl6hko79CGauqdZcz2XPj80UI0YEghRQuCFfcvjTruq2JYeresXjkRkbYdMzmqKhPUOhU0z7AyAlN(aZVbsBclHwfb8nGzpGbUVtfyyOCmmDMKWuEPFDtWcMGG7jQPKXYg6uMHc4rbPbqS36cN(41HfYaPo7QgQozQDVZtwbtaKimZxhfgU)(oUmsIobBOAM60RYTpv4SCn6OjdYxP6sBMvmZ)fNC10EvaonsSMwzc8kUfINiDib56Q6cCDDOoT(lIXGes3tsdnpehlq5mVX3zs)VRd1P40mjDiicwDuO(tyLweMkwkYZLSRtkGzs2eLKO8aqwsWRMc8RmzCGIj6d6DYVcjor0ZxzPwABuNuZG50mLybq1z7u4e4vbTiRNlMUcjjHfXhp00u5k2ncvew7q9ewmroMBPz0gLSWiaqPSPaIodN7UHoMLGjew7ymQyMFLgyplRceOAdKw4jcmYRXH60Wt681iQGwN16l(ukq2q3LtDEdKy2hZ85ccq1mjvG4ztRZ4XYeaMzUcLsvd2DR6WeMkiaKmo7yDwX3nU2mxOFI9nqgnivODFn5tatfsiKnJErvlqpIB0RcuHWIqgc4ozFPPFf8r9KXSAGsdX403guOXjnMfTzkdA342GsrA8Q(gwUz8umdQNoM5KCmjU0zD1N3p3vPkh6OBTuWxJzdASasJqNuXjPrjJMu3rIpsIORUCHbOSNnOoXeEc2GXJk4CBNK6MjZnpDOlkd2N17KRmeagd6LQJnY6DQmuFOtv07gbwy1tRn0UqInxAk4cddMPUV)zyMvgbW3PWKJaVe2pPUPWzMGJr0nuH202pxij(vMoxzSo(cgVEWyJIz55bTsm1(Zcwh9coc1Qb7ob3Qr5ccBVjQVTIAqRMqjKXPb5kRPN9UAc5KhYPuaqqXi2ZGxPmTynGdlkcRKyJPFWmG1jAMFtKSpi9v7HJfwCcCiarGM4zvdKYFMHS1VRsj6nySXkXhZ2yd7EtRZgA7eIq2sIrkGDuB9zAQfXc3wLfsA3ZBiSuuyPiKLjjLYyr8hYe4fjoZ25KqNj1VypGv(wP(FysJzg1P2dTbmGT(mp2ytJcOfcKA9SfIPRxXXgZacWkXGgfVtQGZMa1yi)sLSiYa8du3xNSomdwjKW6emUEZOtcGLOLgpcrbfZOJhOq1cnMqZfiAb3qw7R2MHLqlrkZ3XiMkMHwqti3jSC8jbqQzGmSmL5iflH8OowqZGBhbZLznnh5cJ1zBykSKdGUSdQpdlOZylt4tlBCsm30v7Gaa4CeSfe9hNXbVAgqUbLw4uM5cWoHSIU8MUWeqwyYPLgfMdRa(qelcn2LBdsBOweaz4zyfZNi5OFq0CyPIX(CqgJjtGHtznhomNgGMukw1LgM5bSA(ObAmrPCQbqaKWgdh3n0SaU0XHVloTHDqkiPPUtj0dbayyzIDcQAdvx3(UI9ba8fLtv1P667X5xzszbvgt5XQkaly3MwOrRizAaTRdOXHNY6OhsWbqMpX)AYMW4yMARsMDMf6m8MygiosLXA0XAXniEzoF20tNMWsojDhqc01PX0AbcJkY3ybQFxwy1X87MWRPSODao4BpdaiLJbglr6wf1VBQI33tykb2RWWCOAGuMYkxKcYaaYijua1fyiewc(gMLmUiRzxaghZQZWbHLa7iRRTG2cHeAwizJEBGku2b0bwvWadQgmwjoUiibpKleylRQaf9SWoaryDQLfjLJolYvFF7iRoKVjSrHqJN7iLu3pZn4RMXY6Js50J6GCSWfplYmEUdyhZoPgfoDZy2wKgw6p9Dqo45XPHJnrIobIOFBsqWjMWSJKUFE82Ka(SmN2JyXPfh2wis6xEoKtXYahK25567dylXNerFUAmbrutVtfagj2IW83iOW63bCcZpGuw9kgkfoBmWjS9rY(rboXPHpQrbNW0pHvvyednuIzmWjq7ftJpSlNizuv7Z1VsP1S9hWgnoL8gm)67Wtd9nmvFXWvoKdvCd5Kyt3kxGf0j2FtPxzCvBVbn0hZ4kwPdQPUrMqFMWyGMYqSlzFrm9QOA34)d5FYfehJDUnkq7OtdJJyEzkkWYgO6uEvcZeoOrXWkPSQLvAK(qb7RcGdmBGq)ZiaLrRj59VzqTsCgec2Xg64QGrdocO5kku5RuZnWGfMIybjmvCBHgaPokMyhmyNbkKseRyHmjWAefQqQPZ9WMqdRKpf9tSoiDXHbU01YegpTejzhBOjlRemycG26H3yRDqdR6tSFGDmBIEGo3JH5TkrQZwarGALuMRGmJ1Ol)cJ9xBN7HjyoKZgHpDIjS8XzbAX2MetnewMrJwjHzm0DyUPLCiC86wGzlkyQz(VrZYgRUfsHzy8SptOpckC2((WMT8cCIWKXZfuGE72LEG2lAQyIO8lASU0tQgwBZ4urxWfQAyNu3MwnrhXtNaeiMORTXNzJnVIMdmqYARzr37OJYzMVmQ1WP0tZSSqImmhinJ2xEyC2D0SbIZpiP47PWjL(gidsSsXosuysy3Zh2zggWBWcMYkJyGCNf6zgqGKZStuRCmDPbDuCuM7LxQh0lPP0jU08oDyRZcGiaIfiZHEaWNlaDq6J1FmrCWSFj1hqLMUUfZjbMmQm3juj76RVuMhQaNjuAJnXGVkfKdTG0jPj11erhPsPaRiybWVI9gJSOqOKsrnKYlxcGFYmqYZcID8RKYzilnawNvWWthCqlRdKye3AvJltkqSyMRa6WMgb9jDeJUPJnpPDLtLrtMKIXhOrTPD63eqdnguOPoj0V3nYPOuHe2EnHy7SqHno2RjuSdCbrjX2SDLtXsTGgcivSwAqXFXmRNPWoN0A7aXvJ(JNf5wglCcASwB6(omz2q5rci6H6aE1F0PRu1toflNb65FwtIjDkTft)AxhWjszlR2w3pzgsofZ7DnBTomuXDwB9HLLXKZ3XEIHwfgdT4(LudlAewWB262H0qYPajCgBSaSY2mHzqDpF454emLooIfqxyJTOVp84asBEztLomsz7uYpXs7CZaXw6WgFGQVpOyl8autmiZUXBmdzIhma3U0rrgVBIXgiouAaLya)yaLB)gZGWUbB0a6xvO3S7dtMrfrcLhBMlpdmz69Pm2eRC1vK9GWKHGCMtxSOm1QWsdQpmzGnbdzKMwPhhoEz9BayvHkpkQU7inemzIPsXOZcKY0rJ7cVCi0LwbKAGWCGSiv8vE7UR5LeVowROoPxTk(so8IEIr)Gv1lddAqSQBaxsbkowbhzy2Kefg3g28TyLscP52bkBpitJvENoHm8rjHjx6GRJqz5SFkXu)Jz7MoSGRLQDH1YcepgvLzWMbtGywZwA6JZSk(eZqvbppKPVH8HJS5X6x2EmTeyCUbpGjOkt71DvyU3eZuxM5bEIUFDS2sBrVLYQprAOAJvZQS4vaI)egYYQQEDWAwLnRhQkg6RTaQ9Oy)ITszztj866y0nynRY0XHDok6EaD7ExqIKMouVERx6YaXkSsvtnSOiQ79u7ppHGXxzmh0um79JSH2myzjAhjnzPQMe0GXwEWpChGtd1Kbs7bBchpSjDgNyBta99ZPX(BnpCb6Lmg(HwtJuQMlxJE50abWgzHPDSZoOgju4dpH2n)6zBNXrz(KSjO3a2luvgjFAzjWQQ7JsdMF9updZTdw71U2uppPFXvl5keW2fLMf03c7fk8uPXHXU9IQUa5IhG9GXDGTxfOAnkmB97ZE0Phx5vPV3MjbSSyN28NCLHT)2hb(yw676y6vttwxPzmBxf)owf7b3WT3VQlUft)u61sZlysUYYnAKJwll2zgtuM3Y2GWv2tYxcB9c0DlSXfy0J1CiyRJ0cRvLkXWmAPtOHOhXImJ0QDhT7qYmiM5fjD)rl15Z2NwS9sWUmId2xldSXKPFPn2d2W4zpqwQJTitOeJywf1qrf(dGUQPts3JfC4p8UNtq6Q0SfSqWOspw7xKUXjM3OhwPQ1hT9lc77yjaaBgyYeKmsuHywZlf9hJwtOzQ9ZOiaViI1WHTBE(2dwJHwqb8JCS0dvqMdM(iX9IuhBQYSfx6sQDFBqjcmUpU41mbG)W8mGoLonS7bKq8wskGLwP5SBhyjIgFZ4yr1cHnYz2muO2QiPcOn7M(isDjzzzjXGjOcBphAX(AQvut12720Q9(kjM9zvkFlmwmsg5LWytKwHVUBtRM9f4iMVgzmbeJ6Kdig6ZeMvk1vICNGhXo7alAwi9vCyAWRsphyPPhS67C7KAshZQaI5RsIHTwFxw4xLTGgXXQjzHz1ut75iHnNhgWkAqPnOvKia1Hnmm9EOxM2n4reXJKJ10qwvhv2WGk6AAwaDzHPqyuJVeLCGMffDCMo8Zcu1Skq57s2PDlnb295y9dXgUaT6mmSGs5EZXJPyRE3ozaqjyyX8WUNoB6pH9uclnrfGLz2J2XuS22GoBRlPc9k2udT(MFutI0Sn7KkbnrqIYOWgklmQmIGoW8Bc2JXQbYXIcfV0ebj6KDPraMWmvW05Dzv3q9HeKUA3oJaR2pW5X2ubbiKfIOoITkhOq2WQU3mqeKO3Lbwc2MTzAtf6lw236GnRXu0yyumAJGuQw4WyseZEoyqxFXkrdgVQQPNpA6ebjBsQwYup2yn95OvCtznmGiObmdMfMRrkGoPwEAFov)euwQ6DMYgrjbUNSFNwqsCaXQqwwwbpNPFumusaNz6DecjVF0IILcgLneewlTbZV(Pqa2ebi1eIAlST0SJzWS4VHjvS9Dg2MB6Bgme4gPf6f2ugdgV(zKnSyKPLaJ(ufMdZqMbZ()L0LSS2oMw0ZmyltfEPfNZCXmRD(1pvwOKrsvQAZqrZqrlstxNRKUUIlnWmVErlIjNyc7olsQuh0gEm9DlrMKq(qWd9vuW41VtKq7ItJPu1oTtit)8Jx66rspfI9kHwKfj7GzGbFhiXy7rkikv97ZAAQSd7ZkBNuBZ0p9GzDXXKLG6FcsTiBpNBlj5QrUep6eCF7oTis5YGgePmoFbjIRUFuiz3)Iu08sTjDOg(q8q2o2RiAZK7xb2gvsuEROEr1yclBElNdgr4GnODem4i21ph8NlHzpX3zJQQXePRrXEfadiruyej7zDnb(YMBkbsoufpn4cVRzNjSKb4cGjsJVlo8smAUToNh4T3tQbzv969A0DwP8wQGoux3RaqtE2U2cBsJoIUX3frBsRc29g1mvXP9470l9zubOSTu2oMaQOGeijv6YRSxjLWWiQ2TXltEFAktmBkRHQ1SSqZfxubGnMGQZSjxoyNGoHcI4JehEPSLfrMMujjsdtmpxB6yWwKdDORMvWry)OpIP4lVzdI60)W6lNEOn5b642PSZPiMwhh6D7(oRuZ4RYw6yus4vmrwFH(mdsydzrKjnA3DHOeLoDqeVLUTJ2UOiBUtUncI6ei2D7vAmvBzIpZoQI7L1fySQUSgsfUZlgbGCZ20Q3FjDtilJNHr8)VlmJ1iUsMX5S5Nh79H)q(tIa8Tmn5yFYTkJegQlEo48B3CgKfBmBXfsX6eBgTZThtFGPzBSMx0hJvRcYvYctWFGkPY88HCqdVVEYyX2sAE3yoObG19DnunBgWk3OfcpZuFdht2Y7vJ6Gghtoi2j2LUGS9f5GM40(IJu8chIyB5nEO5fQkOHpBO3EFseJ651Da5s6BegEBDM0R)XM8S(cKnWnM6DP(BQLMkiGXWjskrGSObQ4rEHdzyTTZaPw16zRdsN0CHyRxlklSi067UWHMZd0ooYiXAMKCG60rVhby6WXS7KTD0WgwwCF0ywjD0yjYAcsgZK(1ioB7j8(xIfsIzmFk5yTBi30fU4XVQiy6mX0fNGX0v9XVEU7DOooQUByYzLTZJeMKnzz1D5K93cT5rjLtYWPYgREOf38cvprYYkJTsS3aoFskfxn7uVkwabJvcRdpb39aLn5e2XSzoGwL(JUHsjzwG24)NLLAMBmNe6OVvO)ZYOIYrBsWS7zlfeooVQlVZ4butfZ4GNQLwFNnjA07(JekXwGqgBCJE3FyJfyEq5EglLIKX6ZgSuatLCqK6gdlhZD6C1W82ijLgQDCA8aHhr6v3rmc802Z2lyTa1z7qWTD8BBV)Zhl8p1KhYl5Lp46h4DBOC1KwSQO8MNMYlY6Rx6Vw)QU(a5psUasVQ5sxDGBNora58hbn(6v1xcD4XNTmFZg5IdvUvcLBQVjV5OdU8D)4zN823DP3ZkSIiLuXZxCnSE9)WbNEWBo5mPKSWQNhrSZn5dZawbV)G3EK4oOuanG9OfStk83WChHyO6j4fkgJOwI0H)eeg4jAhE6ZSiwbNezrQKfiWaNjh9tN)JhDbpGXz(R413ZKpCXjhn5s6AKy2HkygTceJsd83i3jU1paDVbVHGycdO9ymHnIcPx3LoZ6GeReacwuHYShOl(5dU4Ito)cjRWJKghkl5fF)7JZ9jV7G3FWz(oydBRFyNlP62SJ)A)6wA4C0pLrSPK4jDIANJSR4sp4cOH0vAo)IyY7(4zxIL9XPSowYORo5fjJVQwJA2voMiKzPpW0CiXNSD8TFZrV)8ZQhciEaSuSfKQKRfHQZ1lo)TF8ijlXztj0WuWH1tF1V9nx8XtEJOlvtfAmO9vPRICMF(z)O)Qde4AstvSpNiem8MlO9eL3gEPy)I98nNNMqUJgX(6PN)6FumZI1GM40uDL9trDN(NbqozVkI3(xvZj64rjsx8MPjTom9vZjgNvM4XSmRQB6HQGtkRC7GKHplfD30XAN8a5m5fESChAkSjZFyZ06RK3RAUtl3MFxXQP(lcA(4E24Fr(F3SyE91YBNrry4kN2Edw3zSc(gd(w(l3sDV3Q9h35Lg7EXo4o3UZZ)BBHm2Cz4f2V15s1c(VZx7VRJKX27Bwr8Y8)rO)Fbe7IH(Xvlxp7U6lU6ZKBr8fRGi4Lp08dLWcsyg3qj61)ZJo71Nlu0tp8IJo4hFZ5)8ztF97o4Il522Bo6Ydo50jtp5SJpF6LF8YZV4Kdov7VW1FZjto4WtpA65NjISM(Hdo7Ot5ln5smqVhd4ho9JV9KZME8jxGF0hpJ)UH(AF4Dhm5Oj83E8hp90PV5Otp6YJM(ZNCg(T8N6)BtF7fN)Xpm99h8JNC2BvJo5KFt(YIYT(lD6QBZ1R451v846kU7CvWnP)2HNvGv)s)SQ67tjdt)4z8pKpY5)0rxCWPN(MdU8GPqWXzY06S4OHhUjF4Otp9GpEXbYq(1QR218vRw)4QzfcjX7ozcwd)hY(yZ6Hp97XM4Rp)9hEWLtV8K3FK)sJF9D3NxE30gIaExYUTeQ0xUaecZwUEtr4VS(EN)B5LRGs5PlMRQVd6z)gz2JLLfR2oT4xEWFlX2Cp7kBGAEXHEyvhMZ)NA5pHAx5pHG8Q)mZ)NkR)3h5)3SkEK)T2poa4L)5ICv)7QN3OQ(5vpVX)NWGwpr)i3sW5FTi8wcEO7142Bj4yGouZUvKiEfqoM2ccHBUvdYQhMH3D0ly47kEcaWx9IUCZLT(TR3MV82fBRKfHJFcCIO6fSuyjmV3TICJbKI4MjVVyzrbPHNCcpzUoFwXNo51NF2KpDYz)00jFBD58PrDk0qPV0p5aqg89Vm521Bh9L)5I8hWe6qmnJcR2TZeZhMC0QVYR6BEjy)9V8VDC(scS7)XGJMm5N((8BwmB6XekyrjF(qRdSdmMVPC93wn6GEGCLj)00jpE91R5HFOveUbNIBxCZJfp3u8GYz54079lwn)958cx)PqBoIhAqxuoYik7)pYBS5JjLdFWjpSOCX2q7tsgyipn)R5p)s(IBFAn(l3o9NwVet41HMYKoWiozjOIF(H81qLY2hllM(H1l2Gt9iDOHpWerNXpYxwCpyqk)lB((x(PIY5lMjegNr4TXrDScYXBho5DMa5gL3ua6TTLlURWtbXOee1XCiDscZqF(gVDz(8f5qsf)ohMpNV8)2LLlwDxXwzHCglhM0UEZJy38CfVJ6hV97F5OFz2T5W6IMVyAxdMy5NK6jNVaKrKc(7FHRqCI1)dQzHbPZ6K7U8s1ZVTCC56nBVA9YTntUkBZQPiTYT)Gm5w)n)h6qiHP95nDl3azZiz3nJJUhGaUF3DdTPx(9Y4DP9dWHqRWMhwSQyZUVNLfoDy((YROKm)I6hbFaqCGZT1pUS)Rk3jxDIh6zm0Fk)N80f3Cl2cxF93)ICT4)(8YTpvsMArsx9xpMvywN4IkUIWte8tR5TG)HnBQr(u3jm6OmJ79HbH7sl(k(sxUMsLR2t8uynbjL33rkD1eC9kUF(2sWm0FTzznyg1jUPuDx125)7lzuQ12)Nk5)gH)J)VP(FQ0Y)Z)7TK7yZMIL(TGj3Tyl47WPEnLilk3WWTkTw1KQLnu2SyzbjqwVEoPIFaQUX8T)0uQiNOoHJvmi2tNjV9tyuKXQ)5olxYobOL7n(lTKjV(wOak4W7IhhG0r7a5vuNy3QLBxfVaOhay27xmR5Rfh3j8TKZZxXKtQwLVlFBjP12HWwL46erx2CeROqof7OY263)Yhw)TIs)C()v(YFnFXVS7eM9WTob9L3G)k)qDYnRe1ZKu9McszC8JB2DFdM2Z(jFyeHjNAs2UCQVVyovkU7Xg35It6eTyTC5n6feTE7SsOZN7f)e2zwd90Vz9YD4)aUdMksDcMmVe6S17Q5ZUB9JGq8hb4pp5c7zTDBqcWMyyVRxi9DpU8o)wjoh4IOrShRUMWymNzzbMjWiiAhQLPvMCsNWmthhAEwsctsOep1U7JNSAZcC4KpGSlxKQtqOzNl)LOYPjA0YT)PDFYpAckTKUovuEF1ldF99xvn4S0S7eAADI0HrfoQ1WIpp15BGW4V)LF(2fajA5UcKT0A)OoHUwioC)9sCyBGTzsssRM8xxCf46UVEFKD1i(O1Kf0fk(dycB5kIvR(8vjIRT1Kc8A7VAnEWMTL5ljOYfx3hv5bZNddm)0Bk2MVy5MpTG6aWFmJ27iVgHNFTanY2q6ysyC33RktBlbeGXRQfrZELx6ZlI(0CkF8NZFAwju4l8SpUzHxdG86YW3kYkkt7pg(z6aMnpiSx924LKLwOkT1ezjsZ8kqu3eXuKx(wepRMxzaJGYTrzPCJ8vTIz4kmoZZVKFtXS1L5EbDKA84L0qf)gQ86Y4RAgF23hBv6XcJ(5h)JkF8HTYrfquNdbYhxMFZ9vkv9fw9wPwscwaP)(VambJFws4ciAp0ex8iayjlGlE8QNQaEWUKHpkfncoPZ6R3ze95rp)4EYmHLBoxbWcOnRYllAbdim8oxZSw6Udndouv)8d(hV)QYILBGeCrXfG0aS81JELIExC4EsudBcl4(9aLzcKeF)pCej6f84RPRJeMe5LLrpPz0tRf4l74SP)SNDM5RRaB8byaICcN)unfdFDz8tBN9kt9gFmBva7z4FF(QfZioVffxJ1XSBRqVY3ug5SwI9S4AAfLCXNUhIDivFBjK(sPXV27TeO)OIMrEFX8XwU10uxi3KjBpB8Wq0fIzz4ma0KE(QTnCt49Lpql7kZvYqQD1E2C(XNkZV7UCEQobSRYh4OA2vwxvY43WTY8ZWem(UK9m(yqRoBFZIhlxjFOxF7ApCewI0YrqCd(ffVAQAehehTpUQJEQOgH96VM7LPsvd8wIHdCd7AQCTy6hy25Bu7zG)5gIDWTkBlWMsplL)1LHVLHvB1HB8U9r6m5HfBlUMwvjmxv4ZyDQldCdVkRV9)aortcfJ1OYK9nP0S9sZ)3EuaQlwjCZY1xvuBZeFBz4tBppzHV4hEjpz3J093VEB9bA(QzBxC9Izy7Vb9M1ZqLfiRPvimTpFFckp(XYfRFe7nxaTRx7DfvR19EbLjT8Rwg7VgbcSmmE(H)DRVVyz(Q5C8PTRVBD5QAi)QezRpr1U3KLwp5zbvNShnt)mSgFZmQt9NVTyR4NXArnmaZYGRdpxZcjiJDp)OFWYL)WLy3)(ogTVPbRLNWmPMtLnK4uDZhG9n69q48gaey9QRxqHze1mfjS5Hksh59LpqlhlVSZRLZhLLQ2JSY3skr)K))R8BUHuONmZVdXRf)e)zBJ7yyvgOAK0yb449OL6MvfcLZXlx)TUB(vGAsAvWA1Tky5qVpQsO54xFYlDhM6i45pEzJ9VE4KjjTB9PQg1iSNWSpxr8M)wE5JpU6FhAyblBELzY14Oz6OkFGwvSwJ297183v5xWKa9SjXTcfsJS69iu4XT5IfpWY87ZV)(101EtA9aIWxL2yJMVnQvdEYXUs4EuISumHDXJ3t3imdy5b7qfFR)9LpqRwwPD6wJFIb7wVpmLx9KW1U8bc(VOYCkPow9oNpv3m7zglwp4SPyLShzoqb1mcgM(Zx4ApS4P1R8AcRga5lyc2F02FN2F8FaXoPuB7hWQR5Cn(RVNFdUkRwP1KB35l0OUntU21eNkCL4YgV3g)34F)jy4)3)cgVR)F8ISWQaJW075aiFJAMyRsYzNQTjO5zFkEF)IYY1vSwviWjnBJRN8qDsR5IzlgP9uG5x8Zp8FaqxHULfyf(6YCVphusj14l07wvUo6wUAQtMWg7rW)95lVj)EpGHVIZzYCvlx2O9(ypTX5BmJJnTYnD29Pr)P)Y8Cm2xMVCXM7Zxvlvd8qsegAyBX2ra0VmMAH7zIpdBifLvWZaEH53SmVA4LxxgFv44N(7)4RBvNBS6qHM7rD(zKK7(CQo8OBUjuUGOqpZN5zTiJDSfg0GmMrxDpa1YfDGacszLR8yvH6rqLzB3vCn4I5f0OEpI6VCX9f)WL3cBPeNNNF)vl86r8VSm4U2TevCTGs2G(X0EVOIVtGw6JZ83ke2YMaCicYYId2XDrnBj8sEypNONNF3Tq8I4PN3cdWfd3UOXMHuplAwJIwEtGu5n1hLqKxRQdIASF4LjErI38MpDLFaMET8(t3UOO0(Q)2d3iFW0MpOTwYP3pkIVJ)n(LkQEZEFJSMVboPAb(Wv4EnHJgPK34pbJY3UQIAyDLlJ8gDwoEh8ShQOBbW4z5WYziW81lZ)gwM)181f)1QWVWsfw7)iQG5TRLbWKyZ2hCzcU)Q8Y7eZ4kzo3uDuZx2p662D(Sy3)qlHDM5MGzES(3NzUoTE0TbB(n6PW5qgK5VhbdLpsLTVPSi)EyoXxRSaYOCsQxiJURDFPfSGJxU5U9WJ9t53LV52)9kSitKCtQiensI)le3o)P)sR(cSog2N3OowSW9Vi6uwSsagcR56dwqf1YgNWUkAZ(VEFsHE96f(OEwu(G4sh6HQAshDC1bqltleRQcfdTpJqpyZTmCAnMzD09xvuUbW3(RpuUE2FTvEuu1EvlVlV(ocTwFFoq6TlUUkkSFSCZIvfeRvD8WRgaFi4Jc)eX)H8jA5K18EHRsNd7667rtPNdiyd7Y1LaqQxTJ8((pqlZS4r1Q1GM)R9WmFiuUVE5I6aiE53w4dXYFTSaW4w5psy1zQ9h(QqE7eDGBG3NPyNwKFDWk5GvZwiKyuaiZaSAjGq9UTk7iA50zVeT1zkSzoUhmJlEWNYaafZY5u5f(ymeR8lnGsLZhvPIpfRMx(4I5tVcQqV9XBMEfJW43UDX2IALmQ2SDG7lQFh2xACrUUIkQvUrCAw6VpSDun7JBk2LZt1kdj2M2eOLi2)12dr7jq5WQ5fBMjlJJGboRQ8gb7DGM4QgLuRue2AjAe0gNSpC1hwSCD5FPe)VBAe2(4QQpaFD)43k6GPJZV)mD6qqaUAztSnaLA2h(0T5Zw(0M7P35PBdOzLhwFea7m8JVkG63M87c1)95B2(BI6F5cs7t3xnDzX1BBi31TsCyEX3C6zJs3xujo4XBES8PGT3puIV5YghJN6doHsBc(eX2)q(eDeWe)7Yw8S))RURSEBBCGW)FkqlK8vSFmPhlk2G0fR2(W(seKSOTvJTKHeDs9(RFNVziPOoCSt2wGTV44itroCUj5mdRYFzOyA56XOvXvWL)gmSVcLjnN05OZk)9(YK1h2k7B0VPku1jyBbA2tnd7BJ6eCZ99dXMHEtv5t9mzmYZDKq3opoLVFwpZ2JC3XDh4is5RfvjpQKtNmYQlbVVmcZ9uwno8hVYQrnktUAKtzcjQsR1D2528xfwQingvK2QBll5Tzwgb59L4YZfyoH8Z8xU7zplUkSWh2VnAXkBDRCeUNntO2JBPmz(peo93aTjVXgpw4UvBHeFViDMI5eUcrqnIfye2ZrHisZJchZFoI)mK)mqcMzxQsrKzv8gZkGjZErh2tDPYfT2iYKlpibCzu9wYP74DQyYmwMKgwLpfNqwP3xPqqAQmr(CSePXOjPen5bY78cZVOtsbuMISgqEY(KSmoM1MAcY6LLfKWBHQYbyJ5RXTMxX(Cen0EpoLCvyDfTQ(m)mMi4Db8AUmFzS9ltWxgXP6YMKAvZOMxJUKMH30Q3R3JWE)u5IrOPd5eRGFRMo8P8m9gumKqY5mF(euznC3LdYCMwhMh4hNSLGj0Dlg1dPi92DOgUfrmkRnPVwvTGHRPgO3exNq0PIejUY7HwtirK4v0dE(PtOBYW9qBML59qC2ChHgrs4yTspmoTZBzWoK4bYXYPZglLPed2PtJfqNtlWctWVNqsHf3hbBMixbDGGbpTGtWktghC(MZzGCecAkmQzxWBWrelEdOx7IBpc5MlOXSE9iYlPhUGgpwsYYwIeLve(QL4Gil4LargM2omj(uSceB57vAlhw6X4LCKRJF0Wd28R95)6Yn4rfDPW55NE8rmCPKDCIWVk6(fsfL2)ZGkoQpvuu9uUAvTIK8ElPmCnsk28L9qPINnVaXJWF6Yh))bZALp6PtXOrdzAzhv3MFdLSjueHMTa153j2BQH(0iRmojoPt0hQ7OxVTDPqRDPqRDPqSEK(exMO6mJeqWbUcfhJ7bs3TwLhO0EuMzgKzMXyMrOF60b5YGn9N3MHjNh7JS8vz0BoyH(POE2IcEWmVRTypSLw9DCOwN3NE046hocJs(VVZ05vdae(qyFLsESbNGeyzhWnS)Ka(2CjavXqZSq0tEoRXdOnL)P0bgwpM4tjY)ce2F1kf)fwyVlz2WhIcJ9KPbb4JPUsG(WsT(Sudkw86SKLKwxwLQonAnTbnn91GwHn6KhxFj9VR91xqR59mmIwVrYfXtWh41fWf1fCWjm9mS1EWdJDWUbComu35WLk3WHh6lvUr48Uy(6n5VaK))fjgGHix3ofLsFkD)wfKJcguzK8Jt4RzMijfwry6uXm4dKfW8sbQkxLVvbvG0yUuAyYHQKyDfj)bdoTYXvnG4wz8QUFoV6VOO4eo1dZv1CfliVgpUU94ztDxz1ONkRB7K)VCwZAbhTlp)RxIq1n2dK8so3VZogSVmVqBjzhLD3u7Vqzg3k6rG5wBngi08VTTUVWyDFHX6(cJ1DC)gOnVbmIISw)tx)1BTDkTOEXY5DF5UpsJUVL3iJvvg3qygj9gX2fiGYiuDDb)JjtTJ)wjc72Ts6oBQUkBuljNj0hSPKgH(zA5Z4o0OghIqfLX4seQNDYCAUX9nMY(bPqUezZK9yCkD8UZykAmncoswWCFeGkQ5QT0u86)g5Eos6z88cAQt)v71D7Ru7l71xnDWhV9tOejGd5qjP5oJRYsoEFuaHDeE)4I8LpOt4PF5YmlBnZxWPMDUEl7uGnp4xs8FGlOwqJarT3wqbqgIJ8RKCEGlkeh2vi1EcURSvmhlIMb9m1kvrD(JQ3IKRx6tuGgKVvA(rdlSRTonxqlSMZD3UnbQZllyUutr)r0GaLdgX(UZf)DoaqiXly8gdihIX3jR3bQt9G00bGZ0gOmDqyKjpDGggNb7r5UcnuzX2JeBeQqg4p6eS)K34EEmtmKnqZJLGuGzQwbr5A1oaj4X477r6cEkqgnWu8IggMFo0a4yQkFkBPKCaTrbAz6Ulnrtyy2(pZ3fVrexLWdHHHcM)n2TFG2bI0zTmw9yjubB2mVBgO572V9aZXzAk)AnTx0eddZ50VW1LP6bhw47uY2TCXzQP3ysKTkKKTVUPlxR2XrhBDmUoCf6RT6WqEWziXRq0Sf3wDh1dh1BYxgdi3GDSYUwAozDcrt3SfalsQ06Qprr2grvJkH0eav9EDb3ER7829NDdI)bSV9eSubTPvwi0al2Itfg3apDqm(PRkiECyNfGnfM3CvEvnxxciDDQkRDXMUHjiviNMYEw9zywuckLftGYNtXQ812scr0UYSsEhTRpKgNO1v5Ph0I1TnLv5)d8hyl5w1EE7H52WnPmMZPUtVrJOykWqnXjWCl2ojV(w3s2QXZyexEnPVtvWpuTwYn0ag8um41g0eAuePvANyx949F6TWR)GqSO(PHlcTv5yYinUEKMC1v4s5HwBNPYNs95tOsbhG7z2fZcMGBSF7fIYgUwHfG6hokCXxzU6bz3sRjBCMAWZi2fGq0t0YtcW7zwsM2w7m(vebp6eiyYTj(c5KVk7N7wK835W04Q3fGRKauOUEEm7Ds0eE54ryxRqeDIj4(GtMXjEZlRGDUdx)AtVYtuX3iHVCYjmP14bHtq6pV(ZFOL0hlCsYR(94ndi5XopLftAZv1wFkBuE4uDywIMzxgCcMY))7kY7dUCVyna8L0VPwQFV1pDgTXQNIKAKGCUIFmbNc)NjJHpMNDazt1FW9NTF)cPLHn8PnDFZa7pmrhs)lmbbym8aD9wxFJttdNwhHogStUJFzZO5iTMcyKWlF))c'

	-- Import profile string
	Details:EraseProfile(name)
	Details:ImportProfile(retail, name)

	-- Apply the profile
	if Details:GetCurrentProfileName() ~= name then
		Details:ApplyProfile(name)
	end

	-- Not included in the profile string, so we enable it manually
	if E.Retail then
		Details.combat_log.evoker_calc_damage = true
		Details.combat_log.evoker_show_realtimedps = true
	end
	
	-- Load the profile on all characters
	_detalhes.always_use_profile = true
	_detalhes.always_use_profile_name = name

	Private:Print(L["Details profile has been set."])
end
