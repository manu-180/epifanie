import reflex as rx
from enum import Enum

class SizeMargen(Enum):
    DIMINUTE = "0.5em"
    VERY_SMALL = "1em"
    SMALL = "1.5em"
    
class Color(Enum):
    VIOLETA = "#AC56B9"
    BACKGROUND = "#FAFDFE"

class ButtonBorder(Enum):
    DEFAULT = "10px"
    
class FloatButton(rx.Component):
    library = "antd"
    tag = "FloatButton"
    icon = rx.image(src="/whatsapp-verde.svg")
    
float_button = FloatButton.create


def index() -> rx.Component:
    return rx.box(
        rx.link(
            float_button(),
            href="https://wa.me/1521554838"
        ),
        navbar(),
        potencia_tu_empresa(),
        servicios_de_marketing(),
        grid_marketing_box(),
        # elegirnos()
    )


def potencia_tu_empresa():
    return rx.box(
        rx.tablet_and_desktop(
            rx.vstack(
                rx.hstack(
                    rx.vstack(
                        rx.heading("La Agencia de", rx.text("Marketing Digital", color=Color.VIOLETA.value), "que acelerará el crecimiento de tu empresa.", size="8"),
                        rx.text("Fuimos reconocidos como socios PREMIER Partner de Google y META Marketing Partner.Brindamos soluciones de marketing digital 360° adaptadas 100% a las necesidades de tu negrocio.", size="6", weight="light"),
                        rx.button(
                            rx.text("Potencia tu empresa hoy",size="3"), 
                            border_radius=ButtonBorder.DEFAULT.value, 
                            padding = SizeMargen.SMALL.value, 
                            bg = Color.VIOLETA.value)
                    ),
                    rx.image(src="/agencia-de-marketing-digital.png", width = "35em", height="auto", margin_left="5em"),
                    margin_top="3em",
                    padding = "4em",
                    text_align="start", 
                    align="center"
                ),
            )
        ),
        rx.mobile_only(
            rx.vstack(
                rx.heading("La Agencia de", rx.text("Marketing Digital", color=Color.VIOLETA.value ), "que acelerará el crecimiento de tu empresa.", size="7"),
                rx.text("Fuimos reconocidos como socios PREMIER Partner de Google y META Marketing Partner.Brindamos soluciones de marketing digital 360° adaptadas 100% a las necesidades de tu negrocio.", size="3", weight="light"),
                rx.button(
                    rx.text("Potencia tu empresa hoy",size="3"), 
                    border_radius=ButtonBorder.DEFAULT.value, 
                    padding = SizeMargen.SMALL.value, 
                    bg = Color.VIOLETA.value
                ),
                rx.image(
                    src="/agencia-de-marketing-digital.png", 
                    width = "100%", 
                    height="auto", 
                    margin_left="5em"
                ),
                margin_top="3em",
                padding = "2em",
                text_align="center", 
                align="center"
            )
        )
    )

def servicios_de_marketing():
    return rx.box(
        rx.tablet_and_desktop(
            rx.vstack(
                rx.vstack(
                    rx.heading("Nuestros Servicios de", rx.text(" Marketing Digital en Argentina", color=Color.VIOLETA.value), size="8" , width="18em" )
                ),
                rx.heading("Estamos capacitados para llevar tu empresa a la cima de Internet y hacer crecer tus ventas.Nuestras soluciones digitales incluyen:", rx.text.strong("Publicidad en Instagram, Tik Tok, Facebook, Google Ads, SEO,Redes Sociales, Email Marketing, Diseño Web, E-commerce ¡y más!"), width="44em",size="4", weight="light" ),
                text_align = "center",
                align="center",
                width = "100%"
            )
        ),
        rx.mobile_only (
            rx.center(
                rx.heading("Nuestros Servicios de", rx.text.strong(" Marketing Digital en Argentina", color=Color.VIOLETA.value), size="8" , width="8em" ),
                text_align = "center",
                width = "100%"
            )
        ),
    )
   
def grid_marketing_box():
    return rx.center(
        rx.chakra.responsive_grid(
            marketing_box("/chart-line-solid.svg","SEO", "Impulsamos el crecimiento de tu negocio en canales orgánicos a través de estrategias de posicionamiento web.", "/seo"),
            marketing_box("/mobile-screen-solid.svg", "Google Ads", "Desarrollamos campañas de búsqueda, display, remarketing, discovery y performance max.Lleva tu empresa a los primeros lugares de Google.","/google_ads" ),
            marketing_box("/users-solid.svg", "Redes Sociales", "Activamos y gestionamos tu presencia online en las redes sociales más importantes del momento, incluyendo Instagram, Facebook, TikTok, LinkedIn, y más.", "/redes_sociales"),
            marketing_box("/space-awesome-brands-solid.svg", "Diseño y Desarrollo Web", "Nos encargamos del diseño de tu sitio web o aplicación abordando todas las necesidades de tu empresa. Desarrollamos sitios de carga rápida y eficientes para el SEO.", "/diseño_desarrollo"),
            marketing_box("/circle-dollar-to-slot-solid (2).svg", "E-commerce", "¿Ventas online? Somos especialistas. Creamos tu tienda online y gestionamos su mantenimiento, y actualizaciones, optimizando las conversiones y las ventas.", "e-comerce"),
            marketing_box("/square-poll-vertical-solid.svg", "Marketing de Contenidos", "Desarrollamos contenido útil para tu público objetivo, respondiendo sus intenciones de búsqueda y generando un posicionamiento SEO que va a repercutir en más ventas para tu empresa.", "/marketing"),
            columns=[1,3],
            width="50em",
            spacing="7"
        ),
        margin_top_="2em"
    ) 
    
def marketing_box(icon,title, text, rute):
    return rx.card(
    rx.vstack(
        rx.inset(
            rx.image(
                src=icon,
                width="auto",
                height="2em",
                margin_left=SizeMargen.DIMINUTE.value
            ),
            side="top",
            pb="current",
        ),
        rx.heading(title, weight="light"),
        rx.text(
            text
        ),
        rx.spacer(),
        ver_mas_button(rute),
        width="15em",
        height="100%",
        margin_bottom="2em",
        padding="1em",
        align_items="stretch",
        spacing="2"
    ),
    height="25em"
)
    
def ver_mas_button(rute):
    return rx.button(
        rx.hstack(
            rx.text("Ver más"),
            rx.icon("arrow-right"),
            spacing="1"
        ),
        on_click=rx.redirect(rute),
        padding = SizeMargen.VERY_SMALL.value,
        height="2.5em",
        width= "8em",
        border_radius =ButtonBorder.DEFAULT.value,
        )

def elegirnos():
    return rx.vstack(
        rx.heading("¿Por que elegir a", rx.hstack(rx.text("Epifanie", color=Color.VIOLETA.value),"?"))
    )


def navbar() -> rx.Component:
    return rx.box(
            rx.mobile_only(
                rx.hstack(
                    rx.box(
                        rx.hstack(
                            rx.mobile_only(
                                rx.link(
                                    rx.text("Epifanie",
                                        white_space="normal",
                                        _hover={"color": "#81396C"}
                                    ),
                                    href="/",
                                    color =  Color.VIOLETA.value
                                )
                            ),
                            rx.tablet_and_desktop(
                                rx.link(
                                    rx.text("Epifanie",
                                        padding_left=SizeMargen.VERY_SMALL.value,
                                        white_space="normal",
                                        _hover={"color": "#81396C"}
                                    ),
                                    href="/",
                                    color =  Color.VIOLETA.value,
                                    width ="9em"
                                )
                            ),
                        )
                    ),
                rx.spacer(),
                options_button(),
                )
            ),
            rx.tablet_and_desktop(
                rx.hstack(
                    rx.box(
                        rx.hstack(
                            rx.mobile_only(
                                rx.link(
                                    rx.text("Epifanie",
                                        white_space="normal",
                                        _hover={"color": "#81396C"}
                                    ),
                                    href="/",
                                    color =  Color.VIOLETA.value
                                )
                            ),
                            rx.tablet_and_desktop(
                                rx.link(
                                    rx.text("Epifanie",
                                        padding_left=SizeMargen.VERY_SMALL.value,
                                        white_space="normal",
                                        _hover={"color": "#81396C"}
                                    ),
                                    href="/",
                                    color =  Color.VIOLETA.value,
                                    width ="9em"
                                )
                            ),
                        rx.spacer(),
                        rx.text("Inicio", weight="light", _hover={"color":Color.VIOLETA.value}),
                        rx.text("Servicios", weight="light", _hover={"color":Color.VIOLETA.value}),
                        rx.text("Clientes", weight="light", _hover={"color":Color.VIOLETA.value}),
                        rx.text("Blog", weight="light", _hover={"color":Color.VIOLETA.value}),
                        rx.text("Contacto", weight="light", _hover={"color":Color.VIOLETA.value}),
                        rx.button("¿Comenzamos?", border_radius= ButtonBorder.DEFAULT.value, bg=Color.VIOLETA.value),
                        spacing="4"),
                        width="100%"
                    ),
                )
            ),
            width = "100%",
            background ="#EAF4FD",
        style=dict(
            font_family="Confortaa-Medium",
            font_size = "1.3em",
            position="sticky",
            padding_y=SizeMargen.DIMINUTE.value,
            padding_x=SizeMargen.DIMINUTE.value,
            z_index="999",
            top="0",
            box_shadow="1px 1px 2px #b8b8b8, -1px -1px 2px #81396C",
            color="#050505",
            font_weight="bold",
            ),
    )

def options_button():
    return rx.box(
            rx.spacer(),
            rx.drawer.root(
            rx.drawer.trigger(
                rx.button(
                    rx.image(src="/list-solid.svg"),
                    variant="ghost",
                    size="2",
                    width="2em",
                    height="2em",
                    padding_x="0px",
                    padding_right=SizeMargen.VERY_SMALL.value,
                    background_color= "#EAF4FD"
                ),
            ),
            rx.drawer.overlay(z_index="5"),
            rx.drawer.portal(
                rx.drawer.content(
                    rx.hstack(
                        rx.box(
                            rx.text("Inicio de sesión"),
                            rx.text("Registrate"),
                            rx.text("Como influencer"),
                            rx.text("Como empresa")
                        ),
                        rx.spacer(),
                        rx.drawer.close(rx.box(rx.icon("circle-x"))),
                        width= "100%"
                    ),
                    top="0",
                    right="0",
                    height="100%",
                    width="100%",
                    padding="2em",
                    background_color=rx.color("gray", 1),
                    z_index="6",
                )
            ),
            direction="left",
        )
    )

app = rx.App(style={"background_color": Color.BACKGROUND.value})
app.add_page(index)
