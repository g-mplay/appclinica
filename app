import { useState, type ReactNode } from "react";

type IconName =
  | "calendar"
  | "chevron-left"
  | "chevron-right"
  | "clock"
  | "heart"
  | "home"
  | "location"
  | "menu"
  | "plus"
  | "search"
  | "stethoscope"
  | "user"
  | "x";

function Icon({ name, size = 20 }: { name: IconName; size?: number }) {
  const paths: Record<IconName, ReactNode> = {
    calendar: (
      <>
        <path d="M7 3v3M17 3v3M4 9h16M5 5h14a1 1 0 0 1 1 1v14H4V6a1 1 0 0 1 1-1Z" />
        <path d="M8 13h2M14 13h2M8 17h2M14 17h2" />
      </>
    ),
    "chevron-left": <path d="m15 18-6-6 6-6" />,
    "chevron-right": <path d="m9 18 6-6-6-6" />,
    clock: (
      <>
        <circle cx="12" cy="12" r="9" />
        <path d="M12 7v5l3 2" />
      </>
    ),
    heart: <path d="M20.8 8.6c0 5.4-8.8 10.3-8.8 10.3S3.2 14 3.2 8.6A4.6 4.6 0 0 1 12 6.8a4.6 4.6 0 0 1 8.8 1.8Z" />,
    home: (
      <>
        <path d="m3 11 9-8 9 8" />
        <path d="M5 10v10h14V10M9 20v-6h6v6" />
      </>
    ),
    location: (
      <>
        <path d="M20 10c0 5-8 11-8 11S4 15 4 10a8 8 0 1 1 16 0Z" />
        <circle cx="12" cy="10" r="2.5" />
      </>
    ),
    menu: <path d="M4 7h16M4 12h16M4 17h16" />,
    plus: <path d="M12 5v14M5 12h14" />,
    search: (
      <>
        <circle cx="11" cy="11" r="7" />
        <path d="m20 20-4-4" />
      </>
    ),
    stethoscope: (
      <>
        <path d="M6 3v6a5 5 0 0 0 10 0V3M4 3h4M14 3h4" />
        <path d="M11 14v2a4 4 0 0 0 8 0v-1" />
        <circle cx="19" cy="13" r="2" />
      </>
    ),
    user: (
      <>
        <circle cx="12" cy="8" r="4" />
        <path d="M4.5 21a7.5 7.5 0 0 1 15 0" />
      </>
    ),
    x: <path d="m6 6 12 12M18 6 6 18" />,
  };

  return (
    <svg
      aria-hidden="true"
      className="icon"
      fill="none"
      height={size}
      viewBox="0 0 24 24"
      width={size}
    >
      {paths[name]}
    </svg>
  );
}

const specialties = [
  { label: "Clínica médica", icon: "stethoscope" as IconName },
  { label: "Cardiología", icon: "heart" as IconName },
  { label: "Traumatología", icon: "plus" as IconName },
  { label: "Más especialidades", icon: "menu" as IconName },
];

const dates = [
  { day: "Lun", number: "17" },
  { day: "Mar", number: "18" },
  { day: "Mié", number: "19" },
  { day: "Jue", number: "20" },
  { day: "Vie", number: "21" },
  { day: "Sáb", number: "22" },
];

const times = ["09:00", "09:40", "10:20", "11:00", "11:40", "12:20"];

type AppointmentStatus = "reserved" | "pending" | "attended" | "missed";

const appointments: {
  time: string;
  patient: string;
  initials: string;
  reason: string;
  professional: string;
  status: AppointmentStatus;
}[] = [
  { time: "08:30", patient: "Sofía Martínez", initials: "SM", reason: "Control general", professional: "Dra. L. Benítez", status: "attended" },
  { time: "09:00", patient: "Carlos Fernández", initials: "CF", reason: "Dolor de pecho", professional: "Dr. M. Torres", status: "reserved" },
  { time: "09:40", patient: "Valentina Ruiz", initials: "VR", reason: "Primera consulta", professional: "Dra. L. Benítez", status: "pending" },
  { time: "10:20", patient: "Martín Acosta", initials: "MA", reason: "Control anual", professional: "Dra. L. Benítez", status: "missed" },
  { time: "11:00", patient: "Elena Domínguez", initials: "ED", reason: "Seguimiento", professional: "Dr. M. Torres", status: "reserved" },
  { time: "11:40", patient: "Tomás Herrera", initials: "TH", reason: "Consulta de rutina", professional: "Dra. L. Benítez", status: "attended" },
  { time: "12:20", patient: "Micaela López", initials: "ML", reason: "Resultados de estudios", professional: "Dr. M. Torres", status: "pending" },
];

const statusContent: Record<AppointmentStatus, { label: string; short: string }> = {
  reserved: { label: "Reservado", short: "Reservados" },
  pending: { label: "Sin confirmar", short: "Sin confirmar" },
  attended: { label: "Asistió", short: "Asistieron" },
  missed: { label: "No asistió", short: "No asistieron" },
};

function InternalDashboard({ onShowPatient }: { onShowPatient: () => void }) {
  const [activeStatus, setActiveStatus] = useState<AppointmentStatus | "all">("all");
  const visibleAppointments = activeStatus === "all"
    ? appointments
    : appointments.filter((appointment) => appointment.status === activeStatus);

  return (
    <div className="internal-shell">
      <aside className="internal-sidebar">
        <a className="brand internal-brand" href="#" aria-label="Lumina Salud">
          <span className="brand-mark"><Icon name="plus" size={19} /></span>
          <span>Lumina<span>Salud</span></span>
        </a>
        <span className="workspace-label">GESTIÓN DE CLÍNICA</span>
        <nav aria-label="Navegación interna">
          <a className="active" href="#agenda"><Icon name="calendar" size={20} /><span>Agenda</span></a>
          <a href="#pacientes"><Icon name="user" size={20} /><span>Pacientes</span></a>
          <a href="#profesionales"><Icon name="stethoscope" size={20} /><span>Profesionales</span></a>
          <a href="#sedes"><Icon name="location" size={20} /><span>Sedes</span></a>
        </nav>
        <div className="sidebar-support">
          <span>LS</span>
          <div><strong>Laura Silva</strong><small>Recepción</small></div>
        </div>
      </aside>

      <main className="internal-main">
        <header className="internal-header">
          <div>
            <span className="section-kicker">CENTRO MÉDICO PALERMO</span>
            <h1>Control de turnos</h1>
            <p>Gestioná la agenda y el estado de cada paciente.</p>
          </div>
          <div className="internal-actions">
            <button className="patient-view-button" onClick={onShowPatient} type="button">
              <Icon name="user" size={18} /> Vista paciente
            </button>
            <button className="new-appointment-button" type="button">
              <Icon name="plus" size={18} /> Nuevo turno
            </button>
          </div>
        </header>

        <section className="status-overview" aria-label="Resumen de turnos">
          {(["reserved", "pending", "attended", "missed"] as AppointmentStatus[]).map((status) => {
            const count = appointments.filter((appointment) => appointment.status === status).length;
            return (
              <button
                className={`status-card status-${status} ${activeStatus === status ? "active" : ""}`}
                key={status}
                onClick={() => setActiveStatus(activeStatus === status ? "all" : status)}
                type="button"
              >
                <span className="status-dot" />
                <span><small>{statusContent[status].short}</small><strong>{count}</strong></span>
                <Icon name="chevron-right" size={18} />
              </button>
            );
          })}
        </section>

        <section className="schedule-panel" id="agenda">
          <div className="schedule-toolbar">
            <div className="date-navigation">
              <button aria-label="Día anterior" type="button"><Icon name="chevron-left" size={18} /></button>
              <div><strong>Martes, 18 de marzo</strong><small>7 turnos programados</small></div>
              <button aria-label="Día siguiente" type="button"><Icon name="chevron-right" size={18} /></button>
            </div>
            <div className="schedule-tools">
              <label className="schedule-search">
                <Icon name="search" size={18} />
                <input aria-label="Buscar paciente" placeholder="Buscar paciente..." />
              </label>
              <button className="today-button" type="button">Hoy</button>
            </div>
          </div>

          <div className="status-legend" aria-label="Referencias de estados">
            <button className={activeStatus === "all" ? "active" : ""} onClick={() => setActiveStatus("all")} type="button">Todos</button>
            {(["reserved", "pending", "attended", "missed"] as AppointmentStatus[]).map((status) => (
              <button
                className={`legend-${status} ${activeStatus === status ? "active" : ""}`}
                key={status}
                onClick={() => setActiveStatus(status)}
                type="button"
              >
                <span />{statusContent[status].label}
              </button>
            ))}
          </div>

          <div className="appointment-table">
            <div className="appointment-row appointment-table-head">
              <span>Hora</span><span>Paciente</span><span>Motivo</span><span>Profesional</span><span>Estado</span><span />
            </div>
            {visibleAppointments.map((appointment) => (
              <div className={`appointment-row row-${appointment.status}`} key={appointment.time}>
                <strong className="appointment-time">{appointment.time}</strong>
                <div className="patient-cell">
                  <span className="patient-initials">{appointment.initials}</span>
                  <div><strong>{appointment.patient}</strong><small>OSDE 210</small></div>
                </div>
                <span className="reason-cell">{appointment.reason}</span>
                <span className="professional-cell">{appointment.professional}</span>
                <span className={`status-pill pill-${appointment.status}`}>
                  <span />{statusContent[appointment.status].label}
                </span>
                <button className="row-menu" aria-label={`Opciones de ${appointment.patient}`} type="button">•••</button>
              </div>
            ))}
          </div>
        </section>
      </main>
    </div>
  );
}

export default function App() {
  const [specialty, setSpecialty] = useState("Clínica médica");
  const [selectedDate, setSelectedDate] = useState("18");
  const [selectedTime, setSelectedTime] = useState("");
  const [confirmed, setConfirmed] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [unavailableAlert, setUnavailableAlert] = useState(true);
  const [internalView, setInternalView] = useState(true);

  if (internalView) {
    return <InternalDashboard onShowPatient={() => setInternalView(false)} />;
  }

  return (
    <div className="app-shell">
      <header className="topbar">
        <a className="brand" href="#" aria-label="Inicio de Lumina Salud">
          <span className="brand-mark">
            <Icon name="plus" size={19} />
          </span>
          <span>Lumina<span>Salud</span></span>
        </a>

        <nav className="desktop-nav" aria-label="Navegación principal">
          <a className="active" href="#inicio">Inicio</a>
          <a href="#turnos">Mis turnos</a>
          <a href="#profesionales">Profesionales</a>
        </nav>

        <div className="header-actions">
          <button className="internal-link" onClick={() => setInternalView(true)} type="button">
            Panel interno
          </button>
          <button
            aria-label="Buscar"
            className="icon-button"
            onClick={() => setSearchOpen(!searchOpen)}
            type="button"
          >
            <Icon name="search" />
          </button>
          <button className="profile-button" type="button">
            <span className="avatar">MP</span>
            <span className="profile-copy"><strong>Marina Pérez</strong><small>Mi cuenta</small></span>
            <Icon name="chevron-right" size={16} />
          </button>
        </div>
      </header>

      {searchOpen && (
        <div className="search-panel">
          <Icon name="search" size={19} />
          <input autoFocus aria-label="Buscar profesionales" placeholder="Buscar profesional o especialidad..." />
        </div>
      )}

      {unavailableAlert && (
        <div className="availability-alert" role="alert">
          <span className="alert-icon"><Icon name="clock" size={22} /></span>
          <div>
            <strong>Este turno ya no está disponible</strong>
            <p>El horario de las 10:20 fue reservado. Por favor, seleccioná otro.</p>
          </div>
          <button
            aria-label="Cerrar alerta"
            onClick={() => setUnavailableAlert(false)}
            type="button"
          >
            <Icon name="x" size={18} />
          </button>
        </div>
      )}

      <main>
        <section className="hero" id="inicio">
          <div className="hero-content">
            <span className="eyebrow"><span /> Cuidamos de vos, siempre</span>
            <h1>Tu salud, en buenas manos.</h1>
            <p>Encontrá al profesional que necesitás y reservá tu turno en pocos minutos.</p>
            <a className="primary-button hero-button" href="#reservar">
              Reservar un turno
              <Icon name="chevron-right" size={18} />
            </a>
          </div>
          <div className="hero-art" aria-hidden="true">
            <span className="orb orb-one" />
            <span className="orb orb-two" />
            <div className="heart-line">
              <Icon name="heart" size={54} />
            </div>
            <span className="spark spark-one">+</span>
            <span className="spark spark-two">+</span>
          </div>
        </section>

        <section className="booking-section" id="reservar">
          <div className="section-heading">
            <div>
              <span className="section-kicker">RESERVÁ ONLINE</span>
              <h2>Elegí cómo empezar</h2>
            </div>
            <p>Seleccioná una especialidad y encontrá el horario que mejor se adapte a vos.</p>
          </div>

          <div className="specialty-grid">
            {specialties.map((item) => (
              <button
                className={`specialty-card ${specialty === item.label ? "selected" : ""}`}
                key={item.label}
                onClick={() => setSpecialty(item.label)}
                type="button"
              >
                <span className="specialty-icon"><Icon name={item.icon} size={23} /></span>
                <span>
                  <strong>{item.label}</strong>
                  <small>{item.label === "Más especialidades" ? "Ver todas las opciones" : "Próximos turnos disponibles"}</small>
                </span>
                <Icon name="chevron-right" size={18} />
              </button>
            ))}
          </div>

          <div className="booking-card">
            <div className="doctor-column">
              <div className="step-label"><span>1</span> Profesional seleccionado</div>
              <div className="doctor-profile">
                <div className="doctor-avatar" aria-label="Doctora Lucía Benítez">
                  <span>LB</span>
                </div>
                <div>
                  <h3>Dra. Lucía Benítez</h3>
                  <p>{specialty === "Más especialidades" ? "Medicina general" : specialty}</p>
                  <div className="rating"><strong>4.9</strong> <span>★★★★★</span> <small>(124 opiniones)</small></div>
                </div>
              </div>
              <div className="doctor-details">
                <p><Icon name="location" size={18} /> Sede Palermo · Av. Santa Fe 3250</p>
                <p><Icon name="clock" size={18} /> Atención presencial · 30 min</p>
              </div>
              <button className="text-button" type="button">Ver perfil profesional <Icon name="chevron-right" size={16} /></button>
            </div>

            <div className="calendar-column">
              <div className="calendar-head">
                <div className="step-label"><span>2</span> Elegí día y horario</div>
                <div className="month-controls">
                  <button aria-label="Mes anterior" type="button"><Icon name="chevron-left" size={17} /></button>
                  <strong>Marzo 2025</strong>
                  <button aria-label="Mes siguiente" type="button"><Icon name="chevron-right" size={17} /></button>
                </div>
              </div>

              <div className="date-row">
                {dates.map((date) => (
                  <button
                    className={selectedDate === date.number ? "selected" : ""}
                    key={date.number}
                    onClick={() => setSelectedDate(date.number)}
                    type="button"
                  >
                    <small>{date.day}</small>
                    <strong>{date.number}</strong>
                  </button>
                ))}
              </div>

              <p className="availability"><span /> 6 horarios disponibles</p>
              <div className="time-grid">
                {times.map((time) => (
                  <button
                    aria-disabled={time === "10:20"}
                    className={`${selectedTime === time ? "selected" : ""} ${time === "10:20" ? "unavailable" : ""}`}
                    key={time}
                    onClick={() => {
                      if (time === "10:20") {
                        setUnavailableAlert(true);
                        return;
                      }
                      setUnavailableAlert(false);
                      setSelectedTime(time);
                    }}
                    type="button"
                  >
                    {time} {time === "10:20" && <small>Ocupado</small>}
                  </button>
                ))}
              </div>

              <button
                className="primary-button confirm-button"
                disabled={!selectedTime}
                onClick={() => setConfirmed(true)}
                type="button"
              >
                Confirmar turno
                <Icon name="chevron-right" size={18} />
              </button>
            </div>
          </div>
        </section>

        <section className="benefits">
          <article>
            <span><Icon name="calendar" size={22} /></span>
            <div><strong>Turnos simples</strong><p>Reservá las 24 horas, estés donde estés.</p></div>
          </article>
          <article>
            <span><Icon name="stethoscope" size={22} /></span>
            <div><strong>Excelencia médica</strong><p>Profesionales elegidos para cuidar de vos.</p></div>
          </article>
          <article>
            <span><Icon name="heart" size={22} /></span>
            <div><strong>Atención cercana</strong><p>Tu bienestar es siempre nuestra prioridad.</p></div>
          </article>
        </section>
      </main>

      <nav className="mobile-nav" aria-label="Navegación móvil">
        <a className="active" href="#inicio"><Icon name="home" size={21} /><span>Inicio</span></a>
        <a href="#reservar"><Icon name="calendar" size={21} /><span>Turnos</span></a>
        <a href="#profesionales"><Icon name="stethoscope" size={21} /><span>Médicos</span></a>
        <a href="#perfil"><Icon name="user" size={21} /><span>Perfil</span></a>
      </nav>

      {confirmed && (
        <div className="modal-backdrop" role="presentation" onClick={() => setConfirmed(false)}>
          <div aria-labelledby="confirmation-title" aria-modal="true" className="confirmation-modal" onClick={(event) => event.stopPropagation()} role="dialog">
            <div className="success-mark"><Icon name="calendar" size={28} /></div>
            <span className="section-kicker">TURNO RESERVADO</span>
            <h2 id="confirmation-title">¡Listo, Marina!</h2>
            <p>Tu turno con la Dra. Lucía Benítez quedó confirmado.</p>
            <div className="appointment-summary">
              <div><Icon name="calendar" size={20} /><span><small>Fecha</small><strong>{selectedDate} de marzo de 2025</strong></span></div>
              <div><Icon name="clock" size={20} /><span><small>Horario</small><strong>{selectedTime} hs</strong></span></div>
              <div><Icon name="location" size={20} /><span><small>Lugar</small><strong>Sede Palermo</strong></span></div>
            </div>
            <button className="primary-button modal-button" onClick={() => setConfirmed(false)} type="button">Ver mis turnos</button>
          </div>
        </div>
      )}
    </div>
  );
}
